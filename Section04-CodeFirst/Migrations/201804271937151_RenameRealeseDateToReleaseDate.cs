namespace Section04_CodeFirst.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class RenameRealeseDateToReleaseDate : DbMigration
    {
        public override void Up()
        {
            RenameColumn("dbo.Videos", "RealeseDate", "ReleaseDate");
        }
        
        public override void Down()
        {
            RenameColumn("dbo.Videos", "ReleaseDate", "RealeseDate");
        }
    }
}
