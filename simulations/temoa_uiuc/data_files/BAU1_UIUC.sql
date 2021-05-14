BEGIN TRANSACTION;
CREATE TABLE "time_season" (
	"t_season"	text,
	PRIMARY KEY("t_season")
);
INSERT INTO "time_season" VALUES('spring');
INSERT INTO "time_season" VALUES('fall');
INSERT INTO "time_season" VALUES('summer');
INSERT INTO "time_season" VALUES('winter');

CREATE TABLE "time_periods" (
	"t_periods"	integer,
	"flag"	text,
	FOREIGN KEY("flag") REFERENCES "time_period_labels"("t_period_labels"),
	PRIMARY KEY("t_periods")
);

-- TO DO figure out when infrastructure was built
INSERT INTO 'time_periods' VALUES (1997, 'e');
INSERT INTO 'time_periods' VALUES (1998, 'e');
INSERT INTO 'time_periods' VALUES (1999, 'e');
INSERT INTO 'time_periods' VALUES (2000, 'e');
INSERT INTO 'time_periods' VALUES (2001, 'e');
INSERT INTO 'time_periods' VALUES (2003, 'e');
INSERT INTO 'time_periods' VALUES (2004, 'e');
INSERT INTO 'time_periods' VALUES (2005, 'e');
INSERT INTO 'time_periods' VALUES (2007, 'e');
INSERT INTO 'time_periods' VALUES (2008, 'e');
INSERT INTO 'time_periods' VALUES (2012, 'e');
INSERT INTO 'time_periods' VALUES (2016, 'e');
INSERT INTO 'time_periods' VALUES (2018, 'e');
INSERT INTO 'time_periods' VALUES (2019, 'e');


-- FUTURE PERIODS
INSERT INTO `time_periods` VALUES (2025,'f');
INSERT INTO `time_periods` VALUES (2030,'f');
INSERT INTO `time_periods` VALUES (2035,'f');
INSERT INTO `time_periods` VALUES (2040,'f');
INSERT INTO `time_periods` VALUES (2045,'f');
INSERT INTO `time_periods` VALUES (2050,'f');
INSERT INTO `time_periods` VALUES (2051,'f');

CREATE TABLE "time_period_labels" (
	"t_period_labels"	text,
	"t_period_labels_desc"	text,
	PRIMARY KEY("t_period_labels")
);
INSERT INTO `time_period_labels` VALUES ('e','existing vintages');
INSERT INTO `time_period_labels` VALUES ('f','future');

CREATE TABLE "time_of_day" (
	"t_day"	text,
	PRIMARY KEY("t_day")
);
INSERT INTO "time_of_day" VALUES('H1');
INSERT INTO "time_of_day" VALUES('H2');
INSERT INTO "time_of_day" VALUES('H3');
INSERT INTO "time_of_day" VALUES('H4');
INSERT INTO "time_of_day" VALUES('H5');
INSERT INTO "time_of_day" VALUES('H6');
INSERT INTO "time_of_day" VALUES('H7');
INSERT INTO "time_of_day" VALUES('H8');
INSERT INTO "time_of_day" VALUES('H9');
INSERT INTO "time_of_day" VALUES('H10');
INSERT INTO "time_of_day" VALUES('H11');
INSERT INTO "time_of_day" VALUES('H12');
INSERT INTO "time_of_day" VALUES('H13');
INSERT INTO "time_of_day" VALUES('H14');
INSERT INTO "time_of_day" VALUES('H15');
INSERT INTO "time_of_day" VALUES('H16');
INSERT INTO "time_of_day" VALUES('H17');
INSERT INTO "time_of_day" VALUES('H18');
INSERT INTO "time_of_day" VALUES('H19');
INSERT INTO "time_of_day" VALUES('H20');
INSERT INTO "time_of_day" VALUES('H21');
INSERT INTO "time_of_day" VALUES('H22');
INSERT INTO "time_of_day" VALUES('H23');
INSERT INTO "time_of_day" VALUES('H24');

CREATE TABLE "technology_labels" (
	"tech_labels"	text,
	"tech_labels_desc"	text,
	PRIMARY KEY("tech_labels")
);
INSERT INTO `technology_labels` VALUES ('r','resource technology');
INSERT INTO `technology_labels` VALUES ('p','production technology');
INSERT INTO `technology_labels` VALUES ('pb','baseload production technology');
INSERT INTO `technology_labels` VALUES ('ps','storage production technology');

CREATE TABLE "technologies" (
	"tech"	text,
	"flag"	text,
	"sector"	text,
	"tech_desc"	text,
	"tech_category"	text,
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("flag") REFERENCES "technology_labels"("tech_labels"),
	PRIMARY KEY("tech")
);
-- Chilled water system
INSERT INTO "technologies" VALUES ('CWS','p','chilled water', 'electric chillers','NULL');
INSERT INTO "technologies" VALUES ('TES','ps','chilled water', 'thermal energy storage','NULL');
INSERT INTO "technologies" VALUES ('CW_PIPE','p','transmission', 'transports water for cooling','NULL');

-- Steam system
INSERT INTO "technologies" VALUES ('STEAM_TUNNEL','p', 'transmission', 'transports steam for cooling','NULL');
INSERT INTO "technologies" VALUES ('ABBOTT','p', 'industrial', 'Abbott power plant','NULL');

INSERT INTO "technologies" VALUES ('IMPELC','r','electric', 'imported electricity','NULL');

CREATE TABLE "tech_reserve" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);


CREATE TABLE "tech_exchange" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);
CREATE TABLE "tech_curtailment" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "tech_flex" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);

CREATE TABLE "tech_annual" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);

CREATE TABLE "sector_labels" (
	"sector"	text,
	PRIMARY KEY("sector")
);
INSERT INTO `sector_labels` VALUES ('supply');
INSERT INTO `sector_labels` VALUES ('electric');
INSERT INTO `sector_labels` VALUES ('chilled water');
INSERT INTO `sector_labels` VALUES ('industrial');
INSERT INTO `sector_labels` VALUES ('transmission');

-- INSERT INTO `sector_labels` VALUES ('transport');
-- INSERT INTO `sector_labels` VALUES ('commercial');
-- INSERT INTO `sector_labels` VALUES ('residential');

CREATE TABLE "regions" (
	"regions"	TEXT,
	"region_note"	TEXT,
	PRIMARY KEY("regions")
);
INSERT INTO `regions` VALUES ('UIUC',NULL);

CREATE TABLE "groups" (
	"group_name"	text,
	"notes"	text,
	PRIMARY KEY("group_name")
);

CREATE TABLE "commodity_labels" (
	"comm_labels"	text,
	"comm_labels_desc"	text,
	PRIMARY KEY("comm_labels")
);
INSERT INTO `commodity_labels` VALUES ('p','physical commodity');
INSERT INTO `commodity_labels` VALUES ('e','emissions commodity');
INSERT INTO `commodity_labels` VALUES ('d','demand commodity');

CREATE TABLE "commodities" (
	"comm_name"	text,
	"flag"	text,
	"comm_desc"	text,
	FOREIGN KEY("flag") REFERENCES "commodity_labels"("comm_labels"),
	PRIMARY KEY("comm_name")
);
INSERT INTO "commodities" VALUES ('ethos','p','# dummy commodity to supply inputs (makes graph easier to read)');
INSERT INTO "commodities" VALUES ('ELC','p','# electricity');
INSERT INTO "commodities" VALUES ('CHILLED_WATER','p','# chilled water');
INSERT INTO "commodities" VALUES ('ABBOTT_STEAM','p','# Abbott Steam');

INSERT INTO "commodities" VALUES ('COOL','d','# university cooling');
INSERT INTO "commodities" VALUES ('HEAT','d','# university heating');

-- INSERT INTO "commodities" VALUES ('IL_DEMAND','d','# electricity');
-- INSERT INTO "commodities" VALUES ('EX_DEMAND','d','# electricity');

-- TO DO: add emissions commodities
-- INSERT INTO "commodities" VALUES ('CO2eq','e','MT/MWh, lifecycle emissions');
-- INSERT INTO "commodities" VALUES ('CO2','e','MT/MWh, generation emissions');
-- INSERT INTO "commodities" VALUES ('SO2','e','MT/MWh, generation emissions');
-- INSERT INTO "commodities" VALUES ('NOx','e','MT/MWh, generation emissions');
-- INSERT INTO "commodities" VALUES ('Hg','e','MT/MWh, generation emissions');
-- INSERT INTO "commodities" VALUES ('e-waste','e','kg/MWh, generation emissions');
-- INSERT INTO "commodities" VALUES ('spent-fuel','e','kg/MWh, generation emissions');


CREATE TABLE "TechOutputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"tech"	TEXT,
	"output_comm"	text,
	"to_split"	real,
	"to_split_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech","output_comm")
);

CREATE TABLE "TechInputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"input_comm"	text,
	"tech"	text,
	"ti_split"	real,
	"ti_split_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","input_comm","tech")
);

CREATE TABLE "StorageDuration" (
	"regions"	text,
	"tech"	text,
	"duration"	real,
	"duration_notes"	text,
	PRIMARY KEY("regions","tech")
);
-- INSERT INTO "StorageDuration" VALUES ('UIUC', 'LI_BATTERY', 4.87, '4.87 hour storage');
INSERT INTO "StorageDuration" VALUES ('UIUC', 'TES', 6.00, 'TES can handle 6 hour peak period');

CREATE TABLE "SegFrac" (
	"season_name"	text,
	"time_of_day_name"	text,
	"segfrac"	real CHECK("segfrac" >= 0 AND "segfrac" <= 1),
	"segfrac_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	PRIMARY KEY("season_name","time_of_day_name")
);

INSERT INTO "SegFrac" VALUES('spring','H1',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H2',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H3',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H4',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H5',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H6',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H7',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H8',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H9',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H10',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H11',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H12',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H13',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H14',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H15',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H16',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H17',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H18',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H19',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H20',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H21',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H22',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H23',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('spring','H24',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H1',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H2',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H3',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H4',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H5',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H6',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H7',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H8',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H9',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H10',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H11',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H12',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H13',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H14',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H15',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H16',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H17',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H18',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H19',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H20',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H21',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H22',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H23',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('fall','H24',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H1',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H2',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H3',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H4',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H5',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H6',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H7',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H8',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H9',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H10',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H11',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H12',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H13',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H14',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H15',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H16',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H17',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H18',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H19',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H20',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H21',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H22',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H23',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('summer','H24',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H1',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H2',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H3',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H4',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H5',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H6',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H7',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H8',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H9',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H10',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H11',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H12',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H13',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H14',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H15',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H16',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H17',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H18',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H19',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H20',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H21',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H22',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H23',1.04166666666666660884e-02,'fraction of year');
INSERT INTO "SegFrac" VALUES('winter','H24',1.04166666666666660884e-02,'fraction of year');

CREATE TABLE "DemandSpecificDistribution" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"demand_name"	text,
	"dds"	real CHECK("dds" >= 0 AND "dds" <= 1),
	"dds_notes"	text,
	FOREIGN KEY("demand_name") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	PRIMARY KEY("regions","season_name","time_of_day_name","demand_name")
);
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H1','COOL',0.008612204258677307,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H2','COOL',0.00829607138409125,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H3','COOL',0.008042971070511643,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H4','COOL',0.008000814988230456,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H5','COOL',0.008067120715245945,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H6','COOL',0.008458626676958408,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H7','COOL',0.00870407279758467,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H8','COOL',0.009497077514177856,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H9','COOL',0.009938336386953394,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H10','COOL',0.01064451031171479,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H11','COOL',0.011263219381804808,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H12','COOL',0.011817966008859928,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H13','COOL',0.012261252151690001,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H14','COOL',0.01278434103584322,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H15','COOL',0.013027712287720605,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H16','COOL',0.013141831704909925,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H17','COOL',0.012906770208814188,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H18','COOL',0.012378776963372185,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H19','COOL',0.011831980082268196,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H20','COOL',0.011151549093945548,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H21','COOL',0.010468860502786411,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H22','COOL',0.010006075486485128,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H23','COOL',0.0095943458899722,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H24','COOL',0.009103513097381907,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H1','COOL',0.008491691517390702,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H2','COOL',0.008282573457373805,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H3','COOL',0.008154931288300032,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H4','COOL',0.00812816562321738,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H5','COOL',0.00841344943908708,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H6','COOL',0.009303036135231804,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H7','COOL',0.009692195079493645,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H8','COOL',0.010386165357238094,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H9','COOL',0.01105924931026854,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H10','COOL',0.011662668822302151,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H11','COOL',0.011990475861727384,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H12','COOL',0.012186729117919166,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H13','COOL',0.012259097189429115,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H14','COOL',0.012428604721650475,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H15','COOL',0.012453667307693941,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H16','COOL',0.012377145420864617,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H17','COOL',0.012059567130975883,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H18','COOL',0.01146640096211839,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H19','COOL',0.010869649750493107,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H20','COOL',0.010529870129637246,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H21','COOL',0.010114707425133223,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H22','COOL',0.009641256749882306,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H23','COOL',0.009288933562787437,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H24','COOL',0.008759768639784475,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H1','COOL',0.008703142891926951,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H2','COOL',0.008485432743854333,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H3','COOL',0.008296438021916503,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H4','COOL',0.00824803932135456,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H5','COOL',0.008365543436689578,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H6','COOL',0.009048851168629019,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H7','COOL',0.009070962758290306,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H8','COOL',0.009542230344299378,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H9','COOL',0.010300725729953808,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H10','COOL',0.010941477799387115,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H11','COOL',0.011521235763517145,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H12','COOL',0.011914863632347863,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H13','COOL',0.01231581117647274,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H14','COOL',0.012775930141675492,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H15','COOL',0.012976843281376977,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H16','COOL',0.012941317321664555,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H17','COOL',0.012567717492521956,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H18','COOL',0.011880868402608396,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H19','COOL',0.01105606645601984,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H20','COOL',0.010694284057787416,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H21','COOL',0.010258422430148254,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H22','COOL',0.009819299359760652,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H23','COOL',0.00943229323483523,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H24','COOL',0.008842203032961928,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H1','COOL',0.010105827762034324,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H2','COOL',0.009957388117318684,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H3','COOL',0.009822643160635625,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H4','COOL',0.009755289197134434,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H5','COOL',0.00973233862691629,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H6','COOL',0.009763293146879298,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H7','COOL',0.00993118437091078,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H8','COOL',0.009920218449490701,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H9','COOL',0.010252446735457542,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H10','COOL',0.010165899360411587,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H11','COOL',0.010190474762073954,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H12','COOL',0.010383389849000469,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H13','COOL',0.011001981442314523,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H14','COOL',0.01120332956880589,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H15','COOL',0.011270331139031066,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H16','COOL',0.011066490556943427,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H17','COOL',0.011239053249080977,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H18','COOL',0.010982135343458507,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H19','COOL',0.01070595244414525,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H20','COOL',0.010624020588106384,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H21','COOL',0.010445042947677176,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H22','COOL',0.010675990956486713,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H23','COOL',0.010444919281519338,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H24','COOL',0.010360358944167024,'');

INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H1','HEAT',0.010426878939360876,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H2','HEAT',0.010291484609781194,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H3','HEAT',0.010250757886957604,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H4','HEAT',0.010305977599112405,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H5','HEAT',0.010398459407798452,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H6','HEAT',0.010528042310376271,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H7','HEAT',0.010765833180745229,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H8','HEAT',0.011269042665166706,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H9','HEAT',0.01132805345899232,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H10','HEAT',0.011117734060847491,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H11','HEAT',0.010751233669730794,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H12','HEAT',0.01052697752657471,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H13','HEAT',0.010368034781772778,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H14','HEAT',0.010275802399502036,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H15','HEAT',0.010229366235584219,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H16','HEAT',0.010041413630997925,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H17','HEAT',0.009917091641457597,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H18','HEAT',0.009900902010507372,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H19','HEAT',0.010028362005440626,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H20','HEAT',0.010117307286607084,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H21','HEAT',0.01023769125491486,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H22','HEAT',0.010278510109840345,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H23','HEAT',0.010328735006397145,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','spring','H24','HEAT',0.01031630832153396,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H1','HEAT',0.010162760561650417,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H2','HEAT',0.010031651123720644,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H3','HEAT',0.009973957351683523,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H4','HEAT',0.00998614506050091,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H5','HEAT',0.010010273847165612,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H6','HEAT',0.010076185040057134,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H7','HEAT',0.0101789303626034,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H8','HEAT',0.010464408780988069,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H9','HEAT',0.01066440877338796,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H10','HEAT',0.010775861065351867,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H11','HEAT',0.010739785605976826,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H12','HEAT',0.010719550452186527,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H13','HEAT',0.01066158665788258,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H14','HEAT',0.010727208602912828,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H15','HEAT',0.010734957434856533,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H16','HEAT',0.010694229246699233,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H17','HEAT',0.010600141557570964,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H18','HEAT',0.01050706974248337,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H19','HEAT',0.010498145452073367,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H20','HEAT',0.010378142951712351,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H21','HEAT',0.010353644665250034,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H22','HEAT',0.010441848651139115,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H23','HEAT',0.01038711050133134,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','summer','H24','HEAT',0.010231996510815368,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H1','HEAT',0.010306967571857124,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H2','HEAT',0.010087744831042092,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H3','HEAT',0.01000723860448785,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H4','HEAT',0.009990130515855712,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H5','HEAT',0.010033747281098114,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H6','HEAT',0.010149673779981114,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H7','HEAT',0.010368953956222733,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H8','HEAT',0.011032958768835706,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H9','HEAT',0.011319827966551243,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H10','HEAT',0.01110109623527561,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H11','HEAT',0.010689350232996195,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H12','HEAT',0.010480377586294214,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H13','HEAT',0.010425402218241462,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H14','HEAT',0.010316829623647888,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H15','HEAT',0.010320009688026736,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H16','HEAT',0.010212887732072374,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H17','HEAT',0.010138680967330383,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H18','HEAT',0.010257005831928897,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H19','HEAT',0.010442768354203755,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H20','HEAT',0.010511721584613906,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H21','HEAT',0.010470717554690867,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H22','HEAT',0.010470766625999555,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H23','HEAT',0.01047025128632546,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','fall','H24','HEAT',0.01039489120242098,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H1','HEAT',0.010360763017810498,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H2','HEAT',0.01020985925180886,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H3','HEAT',0.010164747996577773,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H4','HEAT',0.010176631005132492,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H5','HEAT',0.01022411364485944,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H6','HEAT',0.010302911430568263,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H7','HEAT',0.010528208431728239,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H8','HEAT',0.011066271033288678,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H9','HEAT',0.011294054714304608,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H10','HEAT',0.011057052627902048,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H11','HEAT',0.01067489093667416,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H12','HEAT',0.01040404407476518,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H13','HEAT',0.010280526225015983,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H14','HEAT',0.010177114718148722,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H15','HEAT',0.010128522411275966,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H16','HEAT',0.010076464281314165,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H17','HEAT',0.010145546033360925,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H18','HEAT',0.010338977685963771,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H19','HEAT',0.010454309432516056,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H20','HEAT',0.010444261564586065,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H21','HEAT',0.010397021596531235,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H22','HEAT',0.010383576985770021,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H23','HEAT',0.010373160300916277,'');
INSERT INTO "DemandSpecificDistribution" VALUES ('UIUC','winter','H24','HEAT',0.01033697059918058,'');


CREATE TABLE "Demand" (
	"regions"	text,
	"periods"	integer,
	"demand_comm"	text,
	"demand"	real,
	"demand_units"	text,
	"demand_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("demand_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","periods","demand_comm")
);
INSERT INTO "Demand" VALUES ('UIUC',2025,'COOL',83.848,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2030,'COOL',83.848,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2035,'COOL',83.848,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2040,'COOL',83.848,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2045,'COOL',83.848,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2050,'COOL',83.848,'million ton-hours of refrigeration','based on UIUC data');

INSERT INTO "Demand" VALUES ('UIUC',2025,'HEAT',465.16,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2030,'HEAT',465.16,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2035,'HEAT',465.16,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2040,'HEAT',465.16,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2045,'HEAT',465.16,'million ton-hours of refrigeration','based on UIUC data');
INSERT INTO "Demand" VALUES ('UIUC',2050,'HEAT',465.16,'million ton-hours of refrigeration','based on UIUC data');


CREATE TABLE "PlanningReserveMargin" (
	`regions`	text,
	`reserve_margin`	REAL,
	PRIMARY KEY(regions),
	FOREIGN KEY(`regions`) REFERENCES regions
);
-- INSERT INTO "PlanningReserveMargin" VALUES ('UIUC', 0.15);

CREATE TABLE RampDown(
	"regions" text,
	"tech" text,
	"ramp_down" real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY ("regions", "tech")
);
INSERT INTO "RampDown" VALUES ('UIUC', 'CWS', 0.1978);
INSERT INTO "RampDown" VALUES ('UIUC', 'TES', 0.5830);
INSERT INTO "RampDown" VALUES ('UIUC', 'ABBOTT', 0.3060);


CREATE TABLE RampUp(
	"regions" text,
	"tech" text,
	"ramp_up" real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY ("regions", "tech")
);
INSERT INTO "RampUp" VALUES ('UIUC', 'CWS', 0.1978);
INSERT INTO "RampUp" VALUES ('UIUC', 'TES', 0.5830);
INSERT INTO "RampUp" VALUES ('UIUC', 'ABBOTT', 0.3060);


CREATE TABLE tech_ramping (
	"tech" text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("tech")
);
-- INSERT INTO "tech_ramping" VALUES ('NUCLEAR_NEW');
INSERT INTO "tech_ramping" VALUES ('CWS');
INSERT INTO "tech_ramping" VALUES ('TES');
INSERT INTO "tech_ramping" VALUES ('ABBOTT');

CREATE TABLE "MyopicBaseyear" (
	"year"	real
	"notes"	text
);
CREATE TABLE "MinGenGroupWeight" (
	"regions"	text,
	"tech"	text,
	"group_name"	text,
	"act_fraction"	REAL,
	"tech_desc"	text,
	PRIMARY KEY("tech","group_name","regions")
);
CREATE TABLE "MinGenGroupTarget" (
	"regions"	text,
	"periods"	integer,
	"group_name"	text,
	"min_act_g"	real,
	"notes"	text,
	PRIMARY KEY("periods","group_name","regions")
);
CREATE TABLE "MinCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"mincap"	real,
	"mincap_units"	text,
	"mincap_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);


CREATE TABLE "MinActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"minact"	real,
	"minact_units"	text,
	"minact_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);

CREATE TABLE "MaxCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxcap"	real,
	"maxcap_units"	text,
	"maxcap_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);

CREATE TABLE "MaxActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxact"	real,
	"maxact_units"	text,
	"maxact_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);

CREATE TABLE "LifetimeTech" (
	"regions"	text,
	"tech"	text,
	"life"	real,
	"life_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
INSERT INTO "LifetimeTech" VALUES ('UIUC','CWS',30,'');
INSERT INTO "LifetimeTech" VALUES ('UIUC','TES',60,'');
INSERT INTO "LifetimeTech" VALUES ('UIUC','ABBOTT',40,'');


CREATE TABLE "LifetimeProcess" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"life_process"	real,
	"life_process_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);

CREATE TABLE "LifetimeLoanTech" (
	"regions"	text,
	"tech"	text,
	"loan"	real,
	"loan_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
INSERT INTO "LifetimeLoanTech" VALUES ('UIUC','CWS',10,'');
INSERT INTO "LifetimeLoanTech" VALUES ('UIUC','TES',10,'');
INSERT INTO "LifetimeLoanTech" VALUES ('UIUC','ABBOTT',10,'');



CREATE TABLE "GrowthRateSeed" (
	"regions"	text,
	"tech"	text,
	"growthrate_seed"	real,
	"growthrate_seed_units"	text,
	"growthrate_seed_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);

CREATE TABLE "GrowthRateMax" (
	"regions"	text,
	"tech"	text,
	"growthrate_max"	real,
	"growthrate_max_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);

CREATE TABLE "GlobalDiscountRate" (
	"rate"	real
);
INSERT INTO `GlobalDiscountRate` VALUES (0.05);

CREATE TABLE "ExistingCapacity" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"exist_cap"	real,
	"exist_cap_units"	text,
	"exist_cap_notes"	text,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech","vintage")
);
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 1997, 650, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 1998, 2000, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 1999, 1100, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2000, 3000, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2001, 8950, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2004, 12000, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2005, 2200, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2007, 5000, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2008, 2800, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2012, 7130, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2016, 2200, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2018, 3630, 'tons of refrigeration', 'source: UIUC master plan');
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'CWS', 2019, 1000, 'tons of refrigeration', 'source: UIUC master plan');

INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'TES', 2012, 5000, 'tons of refrigeration', 'source: UIUC master plan');

-- Lots of existing capacity was built mid-century. Based on the "tech lifetime" it won't be counted by Temoa.
-- Therefore I will only list the most recent install year for all "existing capacity" at Abbott
INSERT INTO 'ExistingCapacity' VALUES('UIUC', 'ABBOTT', 2003, 261.04, 'MWth', 'source: UIUC master plan');


CREATE TABLE "EmissionLimit" (
	"regions"	text,
	"periods"	integer,
	"emis_comm"	text,
	"emis_limit"	real,
	"emis_limit_units"	text,
	"emis_limit_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","periods","emis_comm")
);


CREATE TABLE "EmissionActivity" (
	"regions"	text,
	"emis_comm"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"emis_act"	real,
	"emis_act_units"	text,
	"emis_act_notes"	text,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","emis_comm","input_comm","tech","vintage","output_comm")
);


CREATE TABLE "Efficiency" (
	"regions"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"efficiency"	real CHECK("efficiency" > 0),
	"eff_notes"	text,
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","input_comm","tech","vintage","output_comm")
);
-- EXISTING CAPACITY
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 1997, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 1998, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 1999, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2000, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2001, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2004, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2005, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2007, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2008, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2012, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2016, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2018, 'CHILLED_WATER', 1.467, 'tons of refrigeration');
INSERT INTO 'Efficiency' VALUES('UIUC', 'ELC', 'CWS', 2019, 'CHILLED_WATER', 1.467, 'tons of refrigeration');

INSERT INTO 'Efficiency' VALUES('UIUC', 'CHILLED_WATER', 'TES', 2012, 'CHILLED_WATER', 0.95, 'tons of refrigeration');

INSERT INTO 'Efficiency' VALUES('UIUC', 'ethos', 'ABBOTT', 2003, 'ABBOTT_STEAM', 1.00, 'tons of refrigeration');



-- NEW BUILDS
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','IMPELC',2025,'ELC',1.00,'imported electricity');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','IMPELC',2030,'ELC',1.00,'imported electricity');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','IMPELC',2035,'ELC',1.00,'imported electricity');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','IMPELC',2040,'ELC',1.00,'imported electricity');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','IMPELC',2045,'ELC',1.00,'imported electricity');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','IMPELC',2050,'ELC',1.00,'imported electricity');

INSERT INTO "Efficiency" VALUES ('UIUC','ethos','ABBOTT',2025,'ABBOTT_STEAM',1.00,'Abbott generates steam, MWth');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','ABBOTT',2030,'ABBOTT_STEAM',1.00,'Abbott generates steam, MWth');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','ABBOTT',2035,'ABBOTT_STEAM',1.00,'Abbott generates steam, MWth');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','ABBOTT',2040,'ABBOTT_STEAM',1.00,'Abbott generates steam, MWth');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','ABBOTT',2045,'ABBOTT_STEAM',1.00,'Abbott generates steam, MWth');
INSERT INTO "Efficiency" VALUES ('UIUC','ethos','ABBOTT',2050,'ABBOTT_STEAM',1.00,'Abbott generates steam, MWth');

INSERT INTO "Efficiency" VALUES ('UIUC','ABBOTT_STEAM','STEAM_TUNNEL',2025,'HEAT',1.00,'moves low pressure steam to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','ABBOTT_STEAM','STEAM_TUNNEL',2030,'HEAT',1.00,'moves low pressure steam to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','ABBOTT_STEAM','STEAM_TUNNEL',2035,'HEAT',1.00,'moves low pressure steam to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','ABBOTT_STEAM','STEAM_TUNNEL',2040,'HEAT',1.00,'moves low pressure steam to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','ABBOTT_STEAM','STEAM_TUNNEL',2045,'HEAT',1.00,'moves low pressure steam to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','ABBOTT_STEAM','STEAM_TUNNEL',2050,'HEAT',1.00,'moves low pressure steam to buildings');

INSERT INTO "Efficiency" VALUES ('UIUC','ELC','CWS',2025,'CHILLED_WATER',1.467,'GWh to million tons of Refrigeration');
INSERT INTO "Efficiency" VALUES ('UIUC','ELC','CWS',2030,'CHILLED_WATER',1.467,'GWh to million tons of Refrigeration');
INSERT INTO "Efficiency" VALUES ('UIUC','ELC','CWS',2035,'CHILLED_WATER',1.467,'GWh to million tons of Refrigeration');
INSERT INTO "Efficiency" VALUES ('UIUC','ELC','CWS',2040,'CHILLED_WATER',1.467,'GWh to million tons of Refrigeration');
INSERT INTO "Efficiency" VALUES ('UIUC','ELC','CWS',2045,'CHILLED_WATER',1.467,'GWh to million tons of Refrigeration');
INSERT INTO "Efficiency" VALUES ('UIUC','ELC','CWS',2050,'CHILLED_WATER',1.467,'GWh to million tons of Refrigeration');

INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','TES',2025,'CHILLED_WATER',0.95,'Guessing 95% roundtrip efficiency');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','TES',2030,'CHILLED_WATER',0.95,'Guessing 95% roundtrip efficiency');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','TES',2035,'CHILLED_WATER',0.95,'Guessing 95% roundtrip efficiency');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','TES',2040,'CHILLED_WATER',0.95,'Guessing 95% roundtrip efficiency');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','TES',2045,'CHILLED_WATER',0.95,'Guessing 95% roundtrip efficiency');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','TES',2050,'CHILLED_WATER',0.95,'Guessing 95% roundtrip efficiency');

INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','CW_PIPE',2025,'COOL',1.00,'moves chilled water to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','CW_PIPE',2030,'COOL',1.00,'moves chilled water to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','CW_PIPE',2035,'COOL',1.00,'moves chilled water to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','CW_PIPE',2040,'COOL',1.00,'moves chilled water to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','CW_PIPE',2045,'COOL',1.00,'moves chilled water to buildings');
INSERT INTO "Efficiency" VALUES ('UIUC','CHILLED_WATER','CW_PIPE',2050,'COOL',1.00,'moves chilled water to buildings');

CREATE TABLE "DiscountRate" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"tech_rate"	real,
	"tech_rate_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);

CREATE TABLE "CostVariable" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_variable"	real,
	"cost_variable_units"	text,
	"cost_variable_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","tech","vintage")
);
-- EXISTING CAPACITIES
INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 1997, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 1998, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 1999, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2000, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2001, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2001, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2004, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2004, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2005, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2005, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2007, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2007, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'CWS', 2007, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2008, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2008, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'CWS', 2008, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2012, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2012, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'CWS', 2012, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2040, 'CWS', 2012, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2016, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2016, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'CWS', 2016, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2040, 'CWS', 2016, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2045, 'CWS', 2016, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2018, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2018, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'CWS', 2018, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2040, 'CWS', 2018, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2045, 'CWS', 2018, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'CWS', 2019, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'CWS', 2019, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'CWS', 2019, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2040, 'CWS', 2019, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2045, 'CWS', 2019, 7.635054, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostVariable' VALUES('UIUC', 2025, 'ABBOTT', 2003, 0.023009, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2030, 'ABBOTT', 2003, 0.023009, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2035, 'ABBOTT', 2003, 0.023009, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostVariable' VALUES('UIUC', 2040, 'ABBOTT', 2003, 0.023009, 'M$/million ton-hour', 'based on IL cost of water');

-- NEW BUILDS
INSERT INTO "CostVariable" VALUES('UIUC', 2025, 'CWS', 2025, 7.635054, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2030, 'CWS', 2025, 7.635054, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2035, 'CWS', 2025, 7.635054, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'CWS', 2025, 7.635054, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'CWS', 2025, 7.635054, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'CWS', 2025, 7.635054, 'M$/million ton year', 'based on IL cost of water' );

INSERT INTO "CostVariable" VALUES('UIUC', 2030, 'CWS', 2030, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2035, 'CWS', 2030, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'CWS', 2030, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'CWS', 2030, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'CWS', 2030, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostVariable" VALUES('UIUC', 2035, 'CWS', 2035, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'CWS', 2035, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'CWS', 2035, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'CWS', 2035, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'CWS', 2040, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'CWS', 2040, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'CWS', 2040, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'CWS', 2045, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'CWS', 2045, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'CWS', 2050, 7.635054, 'M$/million ton-hour', 'based on IL cost of water' );


INSERT INTO "CostVariable" VALUES('UIUC', 2025, 'ABBOTT', 2025, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2030, 'ABBOTT', 2025, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2035, 'ABBOTT', 2025, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'ABBOTT', 2025, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'ABBOTT', 2025, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'ABBOTT', 2025, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );

INSERT INTO "CostVariable" VALUES('UIUC', 2030, 'ABBOTT', 2030, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2035, 'ABBOTT', 2030, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'ABBOTT', 2030, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'ABBOTT', 2030, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'ABBOTT', 2030, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );

INSERT INTO "CostVariable" VALUES('UIUC', 2035, 'ABBOTT', 2035, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'ABBOTT', 2035, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'ABBOTT', 2035, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'ABBOTT', 2035, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );

INSERT INTO "CostVariable" VALUES('UIUC', 2040, 'ABBOTT', 2040, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'ABBOTT', 2040, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'ABBOTT', 2040, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );

INSERT INTO "CostVariable" VALUES('UIUC', 2045, 'ABBOTT', 2045, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );
INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'ABBOTT', 2045, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );

INSERT INTO "CostVariable" VALUES('UIUC', 2050, 'ABBOTT', 2050, 0.023009, 'M$/GWh(th)', 'source: UIUC master plan' );



CREATE TABLE "CostInvest" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"cost_invest"	real,
	"cost_invest_units"	text,
	"cost_invest_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);

INSERT INTO "CostInvest" VALUES('UIUC', 'CWS', 2025, 0.0018942, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'CWS', 2030, 0.0018942, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'CWS', 2035, 0.0018942, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'CWS', 2040, 0.0018942, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'CWS', 2045, 0.0018942, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'CWS', 2050, 0.0018942, 'M$/ton', 'source: uiuc master plan');

INSERT INTO "CostInvest" VALUES('UIUC', 'TES', 2025, 0.0017856, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'TES', 2030, 0.0017856, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'TES', 2035, 0.0017856, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'TES', 2040, 0.0017856, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'TES', 2045, 0.0017856, 'M$/ton', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'TES', 2050, 0.0017856, 'M$/ton', 'source: uiuc master plan');

INSERT INTO "CostInvest" VALUES('UIUC', 'ABBOTT', 2025, 0.613493, 'M$/MWth', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'ABBOTT', 2030, 0.613493, 'M$/MWth', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'ABBOTT', 2035, 0.613493, 'M$/MWth', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'ABBOTT', 2040, 0.613493, 'M$/MWth', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'ABBOTT', 2045, 0.613493, 'M$/MWth', 'source: uiuc master plan');
INSERT INTO "CostInvest" VALUES('UIUC', 'ABBOTT', 2050, 0.613493, 'M$/MWth', 'source: uiuc master plan');

CREATE TABLE "CostFixed" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_fixed"	real,
	"cost_fixed_units"	text,
	"cost_fixed_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","tech","vintage")
);
-- EXISTING CAPACITY
INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 1997, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 1998, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 1999, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2000, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2001, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2001, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2004, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2004, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2005, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2005, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2007, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2007, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'CWS', 2007, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2008, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2008, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'CWS', 2008, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2012, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2012, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'CWS', 2012, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2040, 'CWS', 2012, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2016, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2016, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'CWS', 2016, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2040, 'CWS', 2016, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2045, 'CWS', 2016, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2018, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2018, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'CWS', 2018, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2040, 'CWS', 2018, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2045, 'CWS', 2018, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'CWS', 2019, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'CWS', 2019, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'CWS', 2019, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2040, 'CWS', 2019, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');
INSERT INTO 'CostFixed' VALUES('UIUC', 2045, 'CWS', 2019, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water');

INSERT INTO 'CostFixed' VALUES('UIUC', 2025, 'ABBOTT', 2003, 79.878, 'M$/GW-year', 'source: UIUC master plan');
INSERT INTO 'CostFixed' VALUES('UIUC', 2030, 'ABBOTT', 2003, 79.878, 'M$/GW-year', 'source: UIUC master plan');
INSERT INTO 'CostFixed' VALUES('UIUC', 2035, 'ABBOTT', 2003, 79.878, 'M$/GW-year', 'source: UIUC master plan');
INSERT INTO 'CostFixed' VALUES('UIUC', 2040, 'ABBOTT', 2003, 79.878, 'M$/GW-year', 'source: UIUC master plan');

-- NEW BUILDS
INSERT INTO "CostFixed" VALUES('UIUC', 2025, 'CWS', 2025, 0.4064098, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2030, 'CWS', 2025, 0.4064098, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2035, 'CWS', 2025, 0.4064098, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'CWS', 2025, 0.4064098, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'CWS', 2025, 0.4064098, 'M$/million ton year', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'CWS', 2025, 0.4064098, 'M$/million ton year', 'based on IL cost of water' );

INSERT INTO "CostFixed" VALUES('UIUC', 2030, 'CWS', 2030, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2035, 'CWS', 2030, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'CWS', 2030, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'CWS', 2030, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'CWS', 2030, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostFixed" VALUES('UIUC', 2035, 'CWS', 2035, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'CWS', 2035, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'CWS', 2035, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'CWS', 2035, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'CWS', 2040, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'CWS', 2040, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'CWS', 2040, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'CWS', 2045, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'CWS', 2045, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'CWS', 2050, 0.4064098, 'M$/million ton-hour', 'based on IL cost of water' );

INSERT INTO "CostFixed" VALUES('UIUC', 2025, 'ABBOTT', 2025, 79.878, 'M$/GW-yea', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2030, 'ABBOTT', 2025, 79.878, 'M$/GW-yea', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2035, 'ABBOTT', 2025, 79.878, 'M$/GW-yea', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'ABBOTT', 2025, 79.878, 'M$/GW-yea', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'ABBOTT', 2025, 79.878, 'M$/GW-yea', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'ABBOTT', 2025, 79.878, 'M$/GW-yea', 'source: UIUC master plan' );

INSERT INTO "CostFixed" VALUES('UIUC', 2030, 'ABBOTT', 2030, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2035, 'ABBOTT', 2030, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'ABBOTT', 2030, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'ABBOTT', 2030, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'ABBOTT', 2030, 79.878, 'M$/GW-year', 'source: UIUC master plan' );

INSERT INTO "CostFixed" VALUES('UIUC', 2035, 'ABBOTT', 2035, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'ABBOTT', 2035, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'ABBOTT', 2035, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'ABBOTT', 2035, 79.878, 'M$/GW-year', 'source: UIUC master plan' );

INSERT INTO "CostFixed" VALUES('UIUC', 2040, 'ABBOTT', 2040, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'ABBOTT', 2040, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'ABBOTT', 2040, 79.878, 'M$/GW-year', 'source: UIUC master plan' );

INSERT INTO "CostFixed" VALUES('UIUC', 2045, 'ABBOTT', 2045, 79.878, 'M$/GW-year', 'source: UIUC master plan' );
INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'ABBOTT', 2045, 79.878, 'M$/GW-year', 'source: UIUC master plan' );

INSERT INTO "CostFixed" VALUES('UIUC', 2050, 'ABBOTT', 2050, 79.878, 'M$/GW-year', 'source: UIUC master plan' );



CREATE TABLE "CapacityToActivity" (
	"regions"	text,
	"tech"	text,
	"c2a"	real,
	"c2a_notes"	TEXT,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
-- INSERT INTO "CapacityToActivity" VALUES ('UIUC','NUCLEAR_NEW',8.76, '');
-- INSERT INTO "CapacityToActivity" VALUES ('UIUC','ABBOTT_PP',8.76, '');
-- INSERT INTO "CapacityToActivity" VALUES ('UIUC','SOLAR_FARM',8.76, '');
-- INSERT INTO "CapacityToActivity" VALUES ('UIUC','SOLAR_RESIDENTIAL',8.76, '');
-- INSERT INTO "CapacityToActivity" VALUES ('UIUC','WIND_FARM',8.76, '');
-- INSERT INTO "CapacityToActivity" VALUES ('UIUC','LI_BATTERY',8.76, '');
INSERT INTO "CapacityToActivity" VALUES ('UIUC','ABBOTT', 8.76, '1 MWth generates 8.76 GWh(th) in a year');
INSERT INTO "CapacityToActivity" VALUES ('UIUC','IMPELC', 8.76, '1 MW import produces 8.76 GWh in a year');
INSERT INTO "CapacityToActivity" VALUES ('UIUC','CW_PIPE', 1.00, 'Transports to building, no conversion');
INSERT INTO "CapacityToActivity" VALUES ('UIUC','CWS', 0.00876, '1 ton produces 0.008760 million ton hours in a year');
INSERT INTO "CapacityToActivity" VALUES ('UIUC','TES', 0.00876, '1 ton produces 0.008760 million ton hours in a year');


CREATE TABLE "CapacityFactorTech" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","season_name","time_of_day_name","tech")
);
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H1','CWS',0.13870190976854713,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H2','CWS',0.1345612684958036,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H3','CWS',0.130963712382295,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H4','CWS',0.12676681375199794,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H5','CWS',0.12050232594005657,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H6','CWS',0.11727391318723948,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H7','CWS',0.11340229909092432,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H8','CWS',0.10755788572062856,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H9','CWS',0.1042436216425148,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H10','CWS',0.10853421182054641,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H11','CWS',0.11171519536558377,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H12','CWS',0.11770079739158879,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H13','CWS',0.12255228564603514,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H14','CWS',0.12885182863139244,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H15','CWS',0.13586900386878017,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H16','CWS',0.1417630922636622,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H17','CWS',0.1426993768673858,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H18','CWS',0.1440991579988557,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H19','CWS',0.14747247084025394,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H20','CWS',0.14962632247036553,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H21','CWS',0.15266813240558177,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H22','CWS',0.15339128179997294,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H23','CWS',0.15086359379624023,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H24','CWS',0.1448481678799554,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H1','CWS',0.3294859006028387,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H2','CWS',0.32318645623740433,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H3','CWS',0.31681659550254954,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H4','CWS',0.31166686209606237,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H5','CWS',0.3025610346536615,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H6','CWS',0.3004658947801223,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H7','CWS',0.29443440402173987,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H8','CWS',0.2918800450577171,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H9','CWS',0.2881161800269398,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H10','CWS',0.29136650739811004,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H11','CWS',0.2890758827805452,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H12','CWS',0.28865689530594885,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H13','CWS',0.28855234723277473,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H14','CWS',0.29142564323588394,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H15','CWS',0.2934322330564836,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H16','CWS',0.29290434363989104,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H17','CWS',0.29035261282315467,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H18','CWS',0.28932092451680713,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H19','CWS',0.2966133367814138,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H20','CWS',0.3216892460142447,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H21','CWS',0.34413260441424437,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H22','CWS',0.35174722896346344,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H23','CWS',0.3493399032632633,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H24','CWS',0.33788917422912756,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H1','CWS',0.18580614626572914,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H2','CWS',0.1815217093831372,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H3','CWS',0.17689079514665376,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H4','CWS',0.1735332613492133,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H5','CWS',0.16606173915513342,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H6','CWS',0.15904922778671596,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H7','CWS',0.1501546217552649,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H8','CWS',0.14521829394829214,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H9','CWS',0.14078801804118882,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H10','CWS',0.141053094044551,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H11','CWS',0.143242289579524,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H12','CWS',0.1466647314134004,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H13','CWS',0.14957903744490061,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H14','CWS',0.15567615782148184,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H15','CWS',0.16064670548634738,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H16','CWS',0.16228321021788455,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H17','CWS',0.1612939022490763,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H18','CWS',0.15963157728931837,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H19','CWS',0.16244683830044132,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H20','CWS',0.1750132424750059,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H21','CWS',0.18655486744606864,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H22','CWS',0.19267780417241231,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H23','CWS',0.19337305622172934,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H24','CWS',0.1866660966084981,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H1','CWS',0.05715255275148723,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H2','CWS',0.05634277268510312,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H3','CWS',0.055604934149973965,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H4','CWS',0.05503409058190815,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H5','CWS',0.05434442742333037,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H6','CWS',0.05326071924069789,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H7','CWS',0.050443982799604666,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H8','CWS',0.04661548691709577,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H9','CWS',0.03911747878033862,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H10','CWS',0.036090879779982675,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H11','CWS',0.03511672764316418,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H12','CWS',0.036449772616274814,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H13','CWS',0.038264500517691764,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H14','CWS',0.03932223530444511,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H15','CWS',0.040251062350471344,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H16','CWS',0.04221756417785687,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H17','CWS',0.04632095482394273,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H18','CWS',0.04605537467466445,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H19','CWS',0.046764028654297726,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H20','CWS',0.048794097456816427,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H21','CWS',0.05146307799025659,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H22','CWS',0.057453142946167976,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H23','CWS',0.05957532290757331,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H24','CWS',0.05922202979676986,'');

INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H1','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H2','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H3','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H4','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H5','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H6','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H7','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H8','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H9','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H10','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H11','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H12','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H13','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H14','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H15','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H16','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H17','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H18','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H19','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H20','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H21','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H22','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H23','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H24','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H1','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H2','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H3','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H4','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H5','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H6','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H7','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H8','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H9','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H10','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H11','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H12','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H13','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H14','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H15','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H16','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H17','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H18','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H19','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H20','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H21','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H22','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H23','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H24','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H1','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H2','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H3','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H4','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H5','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H6','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H7','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H8','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H9','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H10','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H11','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H12','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H13','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H14','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H15','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H16','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H17','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H18','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H19','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H20','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H21','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H22','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H23','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H24','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H1','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H2','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H3','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H4','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H5','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H6','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H7','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H8','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H9','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H10','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H11','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H12','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H13','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H14','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H15','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H16','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H17','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H18','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H19','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H20','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H21','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H22','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H23','TES',0.50,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H24','TES',0.50,'');

INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H1','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H2','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H3','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H4','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H5','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H6','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H7','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H8','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H9','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H10','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H11','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H12','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H13','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H14','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H15','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H16','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H17','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H18','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H19','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H20','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H21','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H22','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H23','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','spring','H24','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H1','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H2','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H3','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H4','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H5','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H6','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H7','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H8','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H9','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H10','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H11','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H12','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H13','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H14','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H15','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H16','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H17','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H18','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H19','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H20','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H21','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H22','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H23','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','summer','H24','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H1','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H2','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H3','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H4','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H5','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H6','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H7','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H8','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H9','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H10','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H11','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H12','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H13','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H14','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H15','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H16','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H17','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H18','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H19','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H20','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H21','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H22','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H23','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','fall','H24','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H1','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H2','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H3','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H4','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H5','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H6','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H7','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H8','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H9','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H10','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H11','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H12','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H13','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H14','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H15','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H16','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H17','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H18','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H19','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H20','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H21','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H22','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H23','ABBOTT',0.6053,'');
INSERT INTO `CapacityFactorTech` VALUES ('UIUC','winter','H24','ABBOTT',0.6053,'');

CREATE TABLE "CapacityFactorProcess" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"vintage"	integer,
	"cf_process"	real CHECK("cf_process" >= 0 AND "cf_process" <= 1),
	"cf_process_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	PRIMARY KEY("regions","season_name","time_of_day_name","tech","vintage")
);

CREATE TABLE "CapacityCredit" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"vintage" integer,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	PRIMARY KEY("regions","periods","tech","vintage")
);
CREATE TABLE "MaxResource" (
	"regions"	text,
	"tech"	text,
	"maxres"	real,
	"maxres_units"	text,
	"maxres_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);

/*
================================================================================
================================================================================
OUTPUT TABLES
================================================================================
================================================================================
*/

CREATE TABLE "Output_V_Capacity" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"tech"	text,
	"vintage"	integer,
	"capacity"	real,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","tech","vintage")
);
CREATE TABLE "Output_VFlow_Out" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_out"	real,
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_VFlow_In" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_in"	real,
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_Objective" (
	"scenario"	text,
	"objective_name"	text,
	"total_system_cost"	real
);
CREATE TABLE "Output_Emissions" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"emissions_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"emissions"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("emissions_comm") REFERENCES "EmissionActivity"("emis_comm"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","t_periods","emissions_comm","tech","vintage")
);
CREATE TABLE "Output_Curtailment" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"curtailment"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_Costs" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"output_name"	text,
	"tech"	text,
	"vintage"	integer,
	"output_cost"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","output_name","tech","vintage")
);
CREATE TABLE "Output_CapacityByPeriodAndTech" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"tech"	text,
	"capacity"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","t_periods","tech")
);


COMMIT;
