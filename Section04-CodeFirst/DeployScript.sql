﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'Section04_CodeFirst.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201804251839099_InitialModel'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [tinyint] NOT NULL,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [RealeseDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [tinyint] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804251839099_InitialModel', N'Section04_CodeFirst.Migrations.Configuration',  0x1F8B0800000000000400DD59DB6EE336107D2FD07F10F4D416899564FBD006F62EB24E5204BBB9204E82BE05B434768852944A5281DDA25FD6877E527FA14349D485946C39BBC8B64580C026678673399C0BFDF79F7F8DDFAD62E63D839034E113FF7074E07BC0C324A27C39F133B5D8FFC17FF7F6EBAFC66751BCF21E0CDD1B4D879C5C4EFC27A5D2E32090E113C4448E621A8A44260B350A93382051121C1D1CFC181C1E0680227C94E579E3DB8C2B1A43FE05BF4E131E42AA32C22E9308982CD77167964BF5AE480C3225214CFC19840A7538F8FE718AB4E75448E57B278C12A9F7D8C2F708E789229AE8F85EC24C89842F67292E1076B74E01E9168449280D38AEC987DA7270A46D096A46232ACCA44AE21D051EBE299D13D8EC2F72B15F390FDD77866E566B6D75EEC289FF13708196DB271D4F99D0549DEE1DE54C7B5EB5B55F6DED559040E4E8BF3D6F9A3195099870C894206CCFBBC9E68C861F607D97FC027CC233C69A3AA296B8D75AC0A51B91A420D4FA1616A5E61791EF056DBEC066ACD81A3C8559EFD70ACDBEC2B3C99C4185806023BBFE6F04208CF04AF8DE25597D04BE544F131F3FFADE395D4164564AA9F79CE20D42262532F7902BF24C97B9D7ADE31E680489F4BD5B60F9B67CA26981E951BEF598C70109CE4512DF26CCB094EB8F77442C012FC35DD2B1394B32115ACA8C831A1F1B51934BDA153539D37F1B35175CBD39EA804DC305339508401F83200AA21BA21408AE6540EEC42F0331EB905B200C249C12559DA53FDFD178C09DE885AB41E34BE16A10D9095783E521703D91320969AE4313AFE6FCB639673CF2362953C2D91881D14064D214B188274FFCEF1CFFF408AC2E632DB0CCBD1B058E838635EE9DC442A90845B0D586FEB63E9DEB6558A98E1B8A05B0BCA4B2C48AADBD163B036505B5F6745B79C7F836BB49610E7BE94C8BBD61AB25A3024F83A40B5C7606D812DE4ADF5AD560A00813D08608A3A39D60DA667520B80A63DDE80445A7633AA2A0A7251A5F9234C52CD16891CA156F56F447D3FDD9EE7D435CC80842D9D13E54DA562761CE234BB076F16893E031BB9039D1C9641AC50E9905DA1E4499C35AB87463657066C8F5E782A5B793B1A5D43E3C47B3624CDCB9856047DAE5CB1B54C288E8A820D3846531EFAB429BB88B9AD0E42F565C09E3C052DCF64FE038C882AAEDEE41C128AFCEA706A3C809BB07A387EF4B07A34F42ABFA3605B5365E3FB8ED2CD511E12A070F086345DB19ACCEEBA3136D57076CE56CD72F83A25C88EA8AB5F64B75F08E3A9545E0853AE54276D4C9AE266E289DA262935440AA8A8B5544C66542DF3E7C3B19BE20F13DD4FD191D85D97DB6960AE2912618CD7E65534611BA35C125E1740152156DBD8FE3EF9135BEFF7B46E940CA880D99A75F7D305194AFA976EB274CB4FC9988F089886F62B2FAB629C91D29761C145FDD1DB92BB64E62AFE3AB41E357849FD5F6F16B37BFBF188B1B72A54BDC97C4B6C7AB3EA611356762B9E011AC26FEEF39D3B177F1F3A3E1DBF3AE05669063EFC0FB63E768D66A5B37688002867707055E36AB76D63C7B20D93EA41E3AA5F69A9F020305DE495824D3299121895CAFE93AB4F1F4720EB4551832DBEA775F5880D0F791302C5752092C584E5F7323280F694A58CB6AB7E60EC922DAA44A9EBD730A29709D1E5C03879CB6A9C5A8445BEEDDE680DEF97F0B70BA1A9346E8DCA87506EC7F069CE1A17C5DE06CEA033F3B70BA1F8EDC517DC0BB50FFB350D106625D9BEBF45464C59ED791CE27A3FE17A32EC9DD4F37DD92FB146F6EF69ED163C2D667ABEABD69F3EB55CF88E3267C67F8DDFA6AD532DB1EC4863F580D32D6BC8C6D31B67B76729394F3ECF25AC6EEF03AE70E4C78431BBF6962869074598BD0BF70F26276AE851A9A0BBE484C92B0343224563373098A600B494E84A20B122ADC0E41CAFCD78307C23224398BE7105DF0EB4CA5994293219EB3D6AF113AD56C3A3F7F826CEB3CBE4EF387FECF6102AA4975177CCDDF67944595DEE71DBD548F089DC3CA7E5FC752E9BE7FB9AE245D257CA0A0D27D55EABD833865284C5EF319798697E8762FE1232C49B836736FBF90ED8168BB7D7C4AC952905896326A7EFC8A188EE2D5DB7F0049B99335DA1F0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804251842298_PopulateGenresTable'
BEGIN
    INSERT INTO Genres VALUES(1, 'Action')
    INSERT INTO Genres VALUES(2, 'Comedy')
    INSERT INTO Genres VALUES(3, 'Thriller')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804251842298_PopulateGenresTable', N'Section04_CodeFirst.Migrations.Configuration',  0x1F8B0800000000000400DD59DB6EE336107D2FD07F10F4D416899564FBD006F62EB24E5204BBB9204E82BE05B434768852944A5281DDA25FD6877E527FA14349D485946C39BBC8B64580C026678673399C0BFDF79F7F8DDFAD62E63D839034E113FF7074E07BC0C324A27C39F133B5D8FFC17FF7F6EBAFC66751BCF21E0CDD1B4D879C5C4EFC27A5D2E32090E113C4448E621A8A44260B350A93382051121C1D1CFC181C1E0680227C94E579E3DB8C2B1A43FE05BF4E131E42AA32C22E9308982CD77167964BF5AE480C3225214CFC19840A7538F8FE718AB4E75448E57B278C12A9F7D8C2F708E789229AE8F85EC24C89842F67292E1076B74E01E9168449280D38AEC987DA7270A46D096A46232ACCA44AE21D051EBE299D13D8EC2F72B15F390FDD77866E566B6D75EEC289FF13708196DB271D4F99D0549DEE1DE54C7B5EB5B55F6DED559040E4E8BF3D6F9A3195099870C894206CCFBBC9E68C861F607D97FC027CC233C69A3AA296B8D75AC0A51B91A420D4FA1616A5E61791EF056DBEC066ACD81A3C8559EFD70ACDBEC2B3C99C4185806023BBFE6F04208CF04AF8DE25597D04BE544F131F3FFADE395D4164564AA9F79CE20D42262532F7902BF24C97B9D7ADE31E680489F4BD5B60F9B67CA26981E951BEF598C70109CE4512DF26CCB094EB8F77442C012FC35DD2B1394B32115ACA8C831A1F1B51934BDA153539D37F1B35175CBD39EA804DC305339508401F83200AA21BA21408AE6540EEC42F0331EB905B200C249C12559DA53FDFD178C09DE885AB41E34BE16A10D9095783E521703D91320969AE4313AFE6FCB639673CF2362953C2D91881D14064D214B188274FFCEF1CFFF408AC2E632DB0CCBD1B058E838635EE9DC442A90845B0D586FEB63E9DEB6558A98E1B8A05B0BCA4B2C48AADBD163B036505B5F6745B79C7F836BB49610E7BE94C8BBD61AB25A3024F83A40B5C7606D812DE4ADF5AD560A00813D08608A3A39D60DA667520B80A63DDE80445A7633AA2A0A7251A5F9234C52CD16891CA156F56F447D3FDD9EE7D435CC80842D9D13E54DA562761CE234BB076F16893E031BB9039D1C9641AC50E9905DA1E4499C35AB87463657066C8F5E782A5B793B1A5D43E3C47B3624CDCB9856047DAE5CB1B54C288E8A820D3846531EFAB429BB88B9AD0E42F565C09E3C052DCF64FE038C882AAEDEE41C128AFCEA706A3C809BB07A387EF4B07A34F42ABFA3605B5365E3FB8ED2CD511E12A070F086345DB19ACCEEBA3136D57076CE56CD72F83A25C88EA8AB5F64B75F08E3A9545E0853AE54276D4C9AE266E289DA262935440AA8A8B5544C66542DF3E7C3B19BE20F13DD4FD191D85D97DB6960AE2912618CD7E65534611BA35C125E1740152156DBD8FE3EF9135BEFF7B46E940CA880D99A75F7D305194AFA976EB274CB4FC9988F089886F62B2FAB629C91D29761C145FDD1DB92BB64E62AFE3AB41E357849FD5F6F16B37BFBF188B1B72A54BDC97C4B6C7AB3EA611356762B9E011AC26FEEF39D3B177F1F3A3E1DBF3AE05669063EFC0FB63E768D66A5B37688002867707055E36AB76D63C7B20D93EA41E3AA5F69A9F020305DE495824D3299121895CAFE93AB4F1F4720EB4551832DBEA775F5880D0F791302C5752092C584E5F7323280F694A58CB6AB7E60EC922DAA44A9EBD730A29709D1E5C03879CB6A9C5A8445BEEDDE680DEF97F0B70BA1A9346E8DCA87506EC7F069CE1A17C5DE06CEA033F3B70BA1F8EDC517DC0BB50FFB350D106625D9BEBF45464C59ED791CE27A3FE17A32EC9DD4F37DD92FB146F6EF69ED163C2D667ABEABD69F3EB55CF88E3267C67F8DDFA6AD532DB1EC4863F580D32D6BC8C6D31B67B76729394F3ECF25AC6EEF03AE70E4C78431BBF6962869074598BD0BF70F26276AE851A9A0BBE484C92B0343224563373098A600B494E84A20B122ADC0E41CAFCD78307C23224398BE7105DF0EB4CA5994293219EB3D6AF113AD56C3A3F7F826CEB3CBE4EF387FECF6102AA4975177CCDDF67944595DEE71DBD548F089DC3CA7E5FC752E9BE7FB9AE245D257CA0A0D27D55EABD833865284C5EF319798697E8762FE1232C49B836736FBF90ED8168BB7D7C4AC952905896326A7EFC8A188EE2D5DB7F0049B99335DA1F0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804251903298_AddGenreToVideosTable'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [tinyint]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804251903298_AddGenreToVideosTable', N'Section04_CodeFirst.Migrations.Configuration',  0x1F8B0800000000000400D559DB6EE336107D2FD07F10F4D41689E5247D680D7B175927298CDD5C102541DF025A1A3B44295225A9C06ED12FEB433FA9BFD0A1EEA2644776BAD9160102879C399CCBE10CC7F9FBCFBFC6EF5711739E412A2AF8C43D1A0C5D07782042CA971337D18BC31FDCF7EFBEFE6A7C1E462BE7A1903B3172A8C9D5C47DD23A1E799E0A9E20226A10D1400A25167A1088C823A1F08E87C31FBDA3230F10C2452CC719DF265CD308D23FF0CFA9E001C43A21EC5284C054BE8E3B7E8AEA5C9108544C0298B83E041A6D187EFF3845D90B2A95769D534689327B6CE13A8473A189111ADD2BF0B5147CE9C7B840D8DD3A06945B10A62077605489F7F565786C7CF12AC5022A489416D18E80472779703C5B7DAF10BB65F0307CE71866BD365EA7219CB83F0197E8B97DD268CAA491EA0CEF20553A70CAADC372EBA0A40432C7FC1C38D384E944C28443A2256107CE4D326734F808EB3BF10BF0094F18ABDB8856E25E6301976EA48841EAF52D2C72CB67A1EB784D3DCF562CD56A3A995B1FD61ADDBEC2B3C99C41C9006FABBAF95D00208DF04AB8CE25597D02BED44F13173FBACE055D4158ACE4A8F79CE20D42252D13EB90B157A5646BA21E680862D744A54AFFEF44CDB83E39EEC8542D04BE16129093208986F086680D921B0C4883F805B2DA3EE4160803056744976799CF7734EA41C32BF24C97A9AF166A7E7B6F81A5BBEA89C659D1CB32FF98EF5F4811DD0A56B0285B7EF4452203638D68EFDD11B904DD8FAAA74A8980A606D4B99A1FDEF4E49C87CE164B722217F6631E9093344616E2B913F7BB5664BAF10AEB6B7879249A78C3C1E0C8F6B1E64DFB3E625FD28422D12A477F5B9FCDCD32AC74C7EDC47E935F5095F3C4B6DFC0FAA0EB0955AE5345BA697FCBFDA67A1A842EF53C9C967ACD570BA3604E4DA28358F6DDDF9EDDD2D8CA4EAF1F4291CF1A421128BBB0345DEA606F99C2EA4DE1658F8AE2F1E16D787D8C2F491C6375A8BD46F215C7CF9E22D3437FF7161D65185EA03A3A75696D7912D63AB2046B178F2E0A3B56153227A6884CC3A825661176039B8AC31A9C6CA7AAE058216E3E672A1B1F0D364A15C30B742BC2829D7A0876A6DB7AE95B9030223B3AC754B024E29BBACF36EDAC17D4F5B39536C2D8B30CB7E3E3B5026451D50E77AF64E437E7B5C9C8EAC1EEC9D8A0F7A593B109A1D175EB408D8DB74F6EB34A7564B8A8BF3DB25888F64A9529B0568C3A0A6D3B1EBDB29B6174E5D8C4A33C773793F2EEB1A7493B1B839531A4E95366A6CCB3AC7C92F571D46E3FEDDCB7BA902D5232AFEC4656D719E71DE0E5C1B8D5123211D741DF9F31C2D80EFCB5D2100D8CC0C0FF954D1945AE57029784D305289DBDFF5D1C4D8FADD1FABF33E67A4A85ACCFACFBE6138CA67C4D4D585F316DF26722832722BF89C8EADB3AD2AB27CA370F471A8A1747B6B78955AF392DC4CFBAD79CD6359D3D7610A13526CC7808AB89FB7BAA3872663F3F16BA07CEB5C49B387286CE1FFBE57DBFF1ACD67F769BA0DA8FF87DE63A241B48C305C2B0542A2DB158B69AF00DCEEA018D096BD8DCEE147D186CE257E2D93B67100337D46CB8D5E7A06D2DB144B5AED24BBEEF38A3B627831E23E8E609346B22782BE626B11919370C639DD3E9E6E1B40BB97B50FC8C836BC3FBDAFCF1E2A8DA9E6F3FCF70DA6EFFC898DAB7E748564597158479D1F0ECED5881163233BE1005692D8B0A11ABA65D82265810C9A9D47441028DDB0128957E69F640588222E7D11CC219BF4E749C687419A2396B7C0967A8BFEDFC74026FDA3CBE8ED32FB8FE0D17D04C6A6AFA35FF90501696765FB46BFA260873A7F2EE6572A94D175BAE4BA42BC17B02E5E12B4BC11D4431433075CD7DF20CFBD876AFE0132C49B02E5E719B415E4E4433ECE3334A9692442AC7A8F4CD7F843CF32FA177FF00100984A0441A0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804251908308_AddClassificationColumnToVideosTable'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [int] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804251908308_AddClassificationColumnToVideosTable', N'Section04_CodeFirst.Migrations.Configuration',  0x1F8B0800000000000400D559DD6EDB3614BE1FB0771074B50DA96527BBD802BB45EB2485D13A09A234D85D404BC70E318AD2482AB037ECC976B147DA2BEC50A2FE28D9919D36DD50A0B0C8730ECFCFC7F3C3FCF3D7DFE337EB88398F20248DF9C41D0D86AE033C8843CA57133755CB573FB96F5E7FFBCDF83C8CD6CE5D4177A2E99093CB89FBA05472EA7932788088C841440311CB78A906411C79248CBDE3E1F0676F34F20045B828CB71C63729573482EC033FA7310F20512961F3380426CD3AEEF89954E79244201312C0C4F52150A8C3F0C7FB29D25E502195EBBC659448BDC796AE43388F15D144A79F24F84AC47CE527B840D8ED2601A45B1226C118705A91F7B56578AC6DF12AC64254904A15477B0A1C9D18E77836FB412E764BE7A1FBCED1CD6AA3ADCE5C3871DF031768B97DD2E994094DD5E9DE41C674E4945BAFCAADA31212881CFDEFC899A64CA502261C5225083B72AED305A3C107D8DCC6BF029FF094B1BA8EA825EE351670E95AC40908B5B981A5D17C16BA8ED7E4F36CC692ADC6939BF56EA3D0EC4B3C9B2C189408F076B2EBFF0B010823BC12AE3327EB8FC057EA61E2E24FD7B9A06B088B1523F513A77883904989D43A64EC5521D919A83B1A42BC6FA032A6FF77A0665C9D1C7744AAE6025FC5021093208882F09A2805826B199039F12B44B57DC80D100612CE882ACFD2BF6F69B43F0CA78C484997343049A1883F5B0EECADA7245F9247BACA68AD334C5EB80196EDCA079A9823324CDD9BFD0B114737312BF0992FDFFB712A026D67DCDEBB256205AAEF2548A3DA15B08D9BC90B465655FADEEF6E34A57DD64B82D00841B00D42A90EE2A6EBE7102D4018D37CCAB0E6BACE1D61297E8E5A816A50BF8F5958D21EEFA6BDD601443F96F4276DDFE75EAE2FBE95320E68E6997AFE31616F1E77CE436707062A709A14364717D2049D86119FB83FB4D4EF9657E0A626CF60B0296F38188C6C0B6BD6B4732CF61A8A505E3A0C0FFD7D73B6D0CBB0561DA8C21EC2004B9ABB6FEBAFC5FAA0EA5749BA4E85F1A6FE2DF39BEC9913BAD88D3B2DF69AAD968CE2CED6283AAEB49DCF7747B754B6D2D3EB27A188674D42E128BB58344DEAC81B6508AB3ED1CB1BC5A2A1F4B67494E3394912BCA6B50ED3AC387EDE5E4E5FF9FBB75D512EC30B6447F7556A5B9E84F58BACC0DAC5A38B3C8495822C884E71D3306A915980DD82A6E2B00626DBA12A305690EBDF26456D6B046D29950F2FD0AC088B706621D8916EF365FD3D6144747403D398A511DFD651ECE2CEEB7B9D3F5F694B187B96E2B67FBC96832CA8DAEEEE150C73739E1B8C3C1FEC1F8C2D7C5F3B18DB24343AA9BAA0C6467F797657511769EFBD3C649AB9AF03374556EF818D82B4170074DAB63CD591BEDBFEE885995C461772B43FCA73F753C9D4A40355DA5B19CCB721CD1AA499D46D76D986F631D42E6AEDD8B76A9B4D5222AFAC71562D1B9BBAF2F4134AABD0E424AE83B63FA287B1C8F81BA9201A688281FF1B9B328A58AF08E684D325489537C1EEF170746C3DC2FC771E443C2943D6E755E4C5675D6CD4716650CF7A97E08F44040F447C1791F5F77549CF7E7B78717764AE7872B87F195FF59AE843FCAD3EDF447F0814AA846341AA35C6CC70465D4FDC3F32C65367F6CB7DC17BE45C09BCD3A7CED0F9F330041D363ED62AD97E135E7BC83864EE44D882D0A8220C93AEC4F19EB6CBF9B5A03CA009610D9DDB35A7CF5DD0FE2BE5D93B679000D7206F98D5E7A05DC5B5946A5DCAA76CDF73866E4F2E3D46E4ED13725E8EF07E2D746073306E19163BA7E7EDC37397E4EE41F60B0ED60DEB6BF3D193A3747BFEFE32C373BB9140C4D4FE62836095745589D0BD11CFBBD04A684133E3CBB800ADA5514162E5B4392882A995BC158A2E49A0703B00CC97FAA1D63C6A9D470B0867FC2A5549AAD0648816ACF1F0ABA1BFEBFCEC85A0A9F3F82AC99E3E3F8709A826D5D5E18ABF4B69EDF1EEA29DD3B789D077CAD4411D4BA5EBE16A534ABA8C794F41C67D652AB8852861284C5E719F3CC221BA7D92F0115624D814FDE076214F07A2E9F6F119252B4122696454FCF889180EA3F5EB7F01C860B283B81C0000 , N'6.2.0-61023')
END

