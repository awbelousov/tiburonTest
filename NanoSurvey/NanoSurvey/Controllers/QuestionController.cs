using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NanoSurvey.Models.DataAccess.Entities;

namespace NanoSurvey.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class QuestionController : ControllerBase
    {
        private readonly TiburonTestContext _context;

        public QuestionController(TiburonTestContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var question = _context.Questions.Include(x => x.Answers).FirstOrDefault(x=> x.Id == id);
            if (question == null)
            {
                return NotFound(new { error = true, msg = "Вопрос не найден" });
            }

            var result = new
            {
                error = false,
                id = question.Id,
                title = question.Title,
                answers = question.Answers.Select(x => new
                {
                    id = x.Id,
                    title = x.Title
                })
            };
            return Ok(result);
        }
    }
}