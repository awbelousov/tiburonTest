using NanoSurvey.Models.DataAccess.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NanoSurvey.Models.DataAccess
{
    public class DbInitializer
    {
        public static void Initialize(TiburonTestContext context)
        {
            if (context.Surveys.Any())
            {
                return;
            }

            var survey = new Survey
            {
                Credate = DateTime.Now,
                Title = "Тестовый опрос"
            };
            context.Surveys.Add(survey);
            context.SaveChanges();

            //question1
            var question1 = new Question
            {
                Title = "Как дела?",
                Credate = DateTime.Now,
                SurveyId = survey.Id,
                Seqnum = 0,
            };
            context.Questions.Add(question1);
            context.SaveChanges();


            var answer1_1 = new Answer
            {
                Title = "Хорошо",
                Credate = DateTime.Now,
                QuestionId = question1.Id
            };
            context.Answers.Add(answer1_1);

            var answer1_2 = new Answer
            {
                Title = "Плохо",
                Credate = DateTime.Now,
                QuestionId = question1.Id
            };
            context.Answers.Add(answer1_2);
            context.SaveChanges();

            //question2
            var question2 = new Question
            {
                Title = "Вы видите солнце прямо сейчас?",
                Credate = DateTime.Now,
                SurveyId = survey.Id,
                Seqnum = 1,
            };
            context.Questions.Add(question2);
            context.SaveChanges();


            var answer2_1 = new Answer
            {
                Title = "Да",
                Credate = DateTime.Now,
                QuestionId = question2.Id
            };
            context.Answers.Add(answer2_1);

            var answer2_2 = new Answer
            {
                Title = "Нет",
                Credate = DateTime.Now,
                QuestionId = question2.Id
            };
            context.Answers.Add(answer2_2);

            context.SaveChanges();




        }
    }
}
