using System;
using System.Collections.Generic;

#nullable disable

namespace NanoSurvey.Models.DataAccess.Entities
{
    public partial class Question
    {
        public Question()
        {
            Answers = new HashSet<Answer>();
        }

        public int Id { get; set; }
        public DateTime Credate { get; set; }
        public string Title { get; set; }
        public int SurveyId { get; set; }
        public int Seqnum { get; set; }

        public virtual Survey Survey { get; set; }
        public virtual ICollection<Answer> Answers { get; set; }
    }
}
