using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Section04_CodeFirst
{
    public class VidzyDbContext : DbContext
    {
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Video> Videos { get; set; }
    }
}
