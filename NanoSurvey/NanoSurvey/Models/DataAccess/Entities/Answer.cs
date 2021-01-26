using System;
using System.Collections.Generic;

#nullable disable

namespace NanoSurvey.Models.DataAccess.Entities
{
    public partial class Answer
    {
        public Answer()
        {
            Results = new HashSet<Result>();
        }

        public int Id { get; set; }
        public DateTime Credate { get; set; }
        public string Title { get; set; }
        public int QuestionId { get; set; }

        public virtual Question Question { get; set; }
        public virtual ICollection<Result> Results { get; set; }
    }
}
