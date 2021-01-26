using System;
using System.Collections.Generic;

#nullable disable

namespace NanoSurvey.Models.DataAccess.Entities
{
    public partial class Survey
    {
        public Survey()
        {
            Interviews = new HashSet<Interview>();
            Questions = new HashSet<Question>();
        }

        public int Id { get; set; }
        public DateTime Credate { get; set; }
        public string Title { get; set; }

        public virtual ICollection<Interview> Interviews { get; set; }
        public virtual ICollection<Question> Questions { get; set; }
    }
}
