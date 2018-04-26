using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Section04_CodeFirst.EntityConfigurations
{
    public class GenreConfiguration : EntityTypeConfiguration<Genre>
    {
        public GenreConfiguration()
        {
            Property(g => g.Name)
                .IsRequired()
                .HasMaxLength(255);
        }
    }
}
