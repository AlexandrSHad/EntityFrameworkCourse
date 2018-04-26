using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Section04_CodeFirst.EntityConfigurations
{
    public class VideoConfiguration : EntityTypeConfiguration<Video>
    {
        public VideoConfiguration()
        {
            Property(v => v.Name)
                .IsRequired()
                .HasMaxLength(255);

            HasRequired(v => v.Genre)
                .WithMany(g => g.Videos)
                .HasForeignKey(v => v.GenreId)
                .WillCascadeOnDelete(false);
        }
    }
}
