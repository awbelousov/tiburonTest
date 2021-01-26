using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NanoSurvey.Models.ApiModels.Result;
using NanoSurvey.Models.DataAccess.Entities;

namespace NanoSurvey.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ResultController : ControllerBase
    {

        private readonly TiburonTestContext _context;

        public ResultController(TiburonTestContext context)
        {
            _context = context;
        }


        [HttpPost("{questionId}")]
        public IActionResult Post(int questionId, [FromBody] ResultModel result)
        {
            if (result == null)
            {
                return BadRequest(new { error = true, msg = "Некорректный запрос." });
            }
            if (string.IsNullOrEmpty(result.RespondentUid))
            {
                return BadRequest(new { error = true, msg = "Не указан RespondentUid." });
            }
            var answer = _context.Answers.Include(x=> x.Question).FirstOrDefault(x => x.Id == result.AnswerId);
            if (answer == null)
            {
                return NotFound(new { error = true, msg = "Не найден вариант ответа." });
            }
            if (answer.QuestionId != questionId)
            {
                return NotFound(new { error = true, msg = "Не найден вариант ответа для указанного вопроса." });
            }

            Interview interview;
            try
            {
                using (var transaction = _context.Database.BeginTransaction())
                {

                    interview = _context.Interviews.FirstOrDefault(x => x.SurveyId == answer.Question.SurveyId && x.RespondentUid == result.RespondentUid);
                    if (interview != null) //проверим, не отвечал ли респондент ранее на этот вопрос
                    {
                        if (_context.Results.Any(x => x.InterviewId == interview.Id && x.Answer.QuestionId == answer.Question.Id))
                        {
                            return BadRequest(new { error = true, msg = "Респондент ранее отвечал на этот вопрос." });
                        }
                    }
                    else
                    {
                        interview = new Interview
                        {
                            SurveyId = answer.Question.SurveyId,
                            Credate = DateTime.Now,
                            RespondentUid = result.RespondentUid,
                        };

                        _context.Interviews.Add(interview);
                        _context.SaveChanges();
                    }

                    _context.Results.Add(new Result
                    {
                        AnswerId = result.AnswerId,
                        Credate = DateTime.Now,
                        InterviewId = interview.Id
                    });
                    _context.SaveChanges();

                    transaction.Commit();
                }
            }
            catch
            {
                return Conflict(new { error = true, msg = "Ошибка сохранения результата (конфликт), попробуйте позже." });
            }

            var nextQuestionId = _context.Questions
                .Where(x => x.SurveyId == answer.Question.SurveyId && x.Seqnum > answer.Question.Seqnum)
                .OrderBy(x => x.Seqnum)
                .Select(x => x.Id)
                .FirstOrDefault();

            if (nextQuestionId == 0)
            {
                interview.CompleteDate = DateTime.Now;
                _context.SaveChanges();
            }

            return Ok(new 
            {
                error = false, 
                nextQuestionId = nextQuestionId == 0 ? null : (int?) nextQuestionId
            });
            
        }
    }
}