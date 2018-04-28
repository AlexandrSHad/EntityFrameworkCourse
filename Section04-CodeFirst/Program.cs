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
            //DisplayGenresAndVideosCount();

            //LoadingReferenceEntity();

            // Note that here I have used a "using" block for each exercise to ensure
            // we start with a new fresh context and the data loaded for each exercise,
            // does not impact our approach to solve subsequent exercises.

            // Exercise 1: Add a new video (Terminator 1)
            // .
            // Here I have hardcoded the GenreId (2). In a real-world application,
            // the user often selects the genre from a drop-down list. There, you should
            // have the Id for each genre. If you're building a WPF application, this 
            // GenreId is already in the memory. If you're building an ASP.NET MVC application,
            // the GenreId is posted with the request and you can set it here. 
            //AddVideo(new Video
            //{
            //    Name = "Terminator 1",
            //    ReleaseDate = new DateTime(1984, 10, 26),
            //    GenreId = 2,
            //    Classification = Classification.Silver
            //});

            // Exercise 2: Add two tags "classics" and "drama" to the database.
            //AddTags("classics", "drama");

            //AddTagsToVideo(20, "classics", "drama", "comedy");

            //RemoveTagsFromVideo(20, "comedy");

            //RemoveVideo(10);

            //RemoveGenre(2, enforceDeletingVideo: true);
        }

        public static void AddVideo(Video video)
        {
            using (var context = new VidzyDbContext())
            {
                context.Videos.Add(video);
                context.SaveChanges();
            }
        }

        public static void AddTags(params string[] tagNames)
        {
            using (var context = new VidzyDbContext())
            {
                // We load the tags with the given names first, to prevent adding duplicates.
                var tags = context.Tags.Where(t => tagNames.Contains(t.Name)).ToList();

                foreach (var name in tagNames)
                {
                    if (!tags.Any(t => t.Name == name))
                    {
                        context.Tags.Add(new Tag { Name = name });
                    }
                }

                context.SaveChanges();
            }
        }

        // In terms of API design, this method expects tag names in the form of a string array.
        // We shouldn't use TagId because that would only work if the given tag exists in the database.
        // But often, in an application with a good user experience, the user should be able to pick a
        // tag from a drop-down list, or add one at the same time as adding or editing a video. So, 
        // we should use tag names to add a new tag to the database. Plus, tag names should be unique, 
        // so conceptually, they can be treated as primary keys, but we use an int (TagId) for optimization.
        public static void AddTagsToVideo(int videoId, params string[] tagNames)
        {
            using (var context = new VidzyDbContext())
            {
                var tags = context.Tags.Where(t => tagNames.Contains(t.Name)).ToList();

                foreach (var name in tagNames)
                {
                    if (!tags.Any(t => t.Name == name))
                    {
                        tags.Add(new Tag { Name = name });
                    }
                }

                var video = context.Videos.Include(v => v.Tags).FirstOrDefault(v => v.Id == videoId);

                if (video != null)
                {
                    foreach (var tag in tags)
                    {
                        if (!video.Tags.Any(t => t == tag))
                        {
                            video.Tags.Add(tag);
                        }
                    }
                }

                context.SaveChanges();
            }
        }

        public static void RemoveTagsFromVideo(int videoId, params string[] tagNames)
        {
            using (var context = new VidzyDbContext())
            {
                var video = context.Videos.Include(v => v.Tags).Single(v => v.Id == videoId);

                foreach (var tagName in tagNames)
                {
                    // I've encapsulated the concept of removing a tag inside the Video class. 
                    // This is the object-oriented way to implement this. The Video class
                    // should be responsible for adding/removing objects to its Tags collection. 
                    video.RemoveTag(tagName);
                }

                context.SaveChanges();
            }
        }

        public static void RemoveVideo(int videoId)
        {
            using (var context = new VidzyDbContext())
            {
                var video = context.Videos.FirstOrDefault(v => v.Id == videoId);

                if (video == null) return;
                
                context.Videos.Remove(video);
                context.SaveChanges();
            }
        }

        public static void RemoveGenre(int genreId, bool enforceDeletingVideo = false)
        {
            using (var context = new VidzyDbContext())
            {
                var genre = context.Genres.Include(g => g.Videos).FirstOrDefault(g => g.Id == genreId);

                if (genre == null) return;

                if (genre.Videos.Any())
                {
                    if (enforceDeletingVideo)
                    {
                        context.Videos.RemoveRange(genre.Videos);
                    }
                    else
                    {
                        throw new Exception(String.Format("Genre {0} contains some video, and can not be deleted.", genre.Name));
                    }
                }

                context.Genres.Remove(genre);
                context.SaveChanges();
            }
        }

        public static void DisplayGenresAndVideosCount()
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

        public static void LoadingReferenceEntity()
        {
            var context = new VidzyDbContext();

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
