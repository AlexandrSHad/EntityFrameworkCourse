namespace Section04_CodeFirst.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class PopulateGenresTable : DbMigration
    {
        public override void Up()
        {
            Sql("INSERT INTO Genres VALUES(1, 'Action')");
            Sql("INSERT INTO Genres VALUES(2, 'Comedy')");
            Sql("INSERT INTO Genres VALUES(3, 'Thriller')");
        }
        
        public override void Down()
        {
            Sql("DELETE FROM Genres WHERE Id BETWEEN 1 AND 3");
        }
    }
}
