using System;
using System.Collections.Generic;
using System.Data.Entity;
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


            //// To enable lazy loading, you need to declare navigation properties
            //// as virtual. Look at the Video class.

            //var videos = context.Videos.ToList();

            //Console.WriteLine();
            //Console.WriteLine("LAZY LOADING");
            //foreach (var v in videos)
            //    Console.WriteLine("{0} ({1})", v.Name, v.Genre.Name);

            //// Eager loading
            //var videosWithGenres = context.Videos.Include(v => v.Genre).ToList();

            //Console.WriteLine();
            //Console.WriteLine("EAGER LOADING");
            //foreach (var v in videosWithGenres)
            //    Console.WriteLine("{0} ({1})", v.Name, v.Genre.Name);

            // Explicit loading

            // NOTE: At this point, genres are already loaded into the context,
            // so the following line is not going to make a difference. If you 
            // want to see expicit loading in action, comment out the eager loading 
            // part as well as the foreach block in the lazy loading.

            // Explicit loading
            var videos = context.Videos.ToList();

            var genresIds = videos.Select(v => v.GenreId).Distinct();

            context.Genres.Where(g => genresIds.Contains(g.Id)).Load();

            foreach (var v in videos)
            {
                Console.WriteLine("{0} [{1}]", v.Name, v.Genre.Name);
            }
        }
    }
}
