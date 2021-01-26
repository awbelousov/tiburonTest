using System;
using System.Collections.Generic;

#nullable disable

namespace NanoSurvey.Models.DataAccess.Entities
{
    public partial class Interview
    {
        public Interview()
        {
            Results = new HashSet<Result>();
        }

        public int Id { get; set; }
        public DateTime Credate { get; set; }
        public string RespondentUid { get; set; }
        public int SurveyId { get; set; }
        public DateTime? CompleteDate { get; set; }

        public virtual Survey Survey { get; set; }
        public virtual ICollection<Result> Results { get; set; }
    }
}
