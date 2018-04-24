using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Section03_DatabaseFirst
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = new VidzyDbContext();

            context.AddVideo("Saw", new DateTime(2010, 5, 12), "Thriller");
            context.AddVideo("Las-Vegas", new DateTime(2015, 1, 27), "Comedy");
            context.AddVideo("Adrenalin", new DateTime(2000, 3, 7), "Action");

            Console.ReadLine();
        }
    }
}
