using System;
using System.Collections.Generic;

#nullable disable

namespace NanoSurvey.Models.DataAccess.Entities
{
    public partial class Result
    {
        public int Id { get; set; }
        public DateTime Credate { get; set; }
        public int AnswerId { get; set; }
        public int InterviewId { get; set; }

        public virtual Answer Answer { get; set; }
        public virtual Interview Interview { get; set; }
    }
}
