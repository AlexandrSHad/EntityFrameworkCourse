using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Section04_CodeFirst
{
    public class Video
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime ReleaseDate { get; set; }
        public byte GenreId { get; set; }
        public Genre Genre { get; set; }
        public Classification Classification { get; set; }
        public ICollection<Tag> Tags { get; set; } = new HashSet<Tag>();

        public void AddTag(Tag tag)
        {
            Tags.Add(tag);
        }

        public void RemoveTag(string tagName)
        {
            // I'm using SingleOrDefault here because the given tag may not be associated with the given 
            // in the first place!
            var tag = Tags.SingleOrDefault(t => t.Name.Equals(tagName, StringComparison.CurrentCultureIgnoreCase));

            if (tag != null)
                Tags.Remove(tag);
        }
    }
}
