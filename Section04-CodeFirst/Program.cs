using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Section04_CodeFirst
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = new VidzyDbContext();

            var genres = context.Genres
                .GroupJoin(context.Videos,
                    g => g.Id, v => v.GenreId,
                    (g, v) => new {
                        GenreName = g.Name,
                        VideosCount = v.Count()
                    })
                .OrderByDescending(r => r.VideosCount);

            foreach (var g in genres)
            {
                Console.WriteLine("{0} ({1})", g.GenreName, g.VideosCount);
            }
        }
    }
}
