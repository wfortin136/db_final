Weightclass.delete_all
fly = Weightclass.create(name: "Flyweight", weight: 125)
bant = Weightclass.create(name: "Bantomweight", weight: 135)
feat = Weightclass.create(name: "Featherweight", weight: 145)
light = Weightclass.create(name: "Lightweight", weight: 155)
welt = Weightclass.create(name: "Welterweight", weight: 170)
mid = Weightclass.create(name: "Middleweight", weight: 185)
lheavy = Weightclass.create(name: "Light Heavyweight", weight: 205)
heavy = Weightclass.create(name: "Heavyweight", weight: 265)

User.delete_all
User.create(name: "admin", email: "admin@example.com", admin: true, password: "test")
User.create(name: "billy", email: "billy@example.com", admin: false, password: "test")

Judge.delete_all
chris_lee = Judge.create(name: "Chris Lee")
tony_weeks = Judge.create(name: "Tony Weeks")
derek_cleary = Judge.create(name: "Derek Cleary")
sal = Judge.create(name: "Sal D'Amato")
marco = Judge.create(name: "Marco Rosales")
glenn_t = Judge.create(name: "Glenn Trowbridge")
roy_s = Judge.create(name: "Roy Silbert")

Fighter.delete_all
tj = Fighter.create(name: "T.J. Dillashaw", wins: 12, losses: 2, draws: 0, nc: 0, picture: "http://www.sherdog.com/image_crop.php?image=http://www.origin.sherdog.com/_images/fighter/20131219095141_tj_dillashaw.JPG&&width=200&&height=300")
renan = Fighter.create(name: "Renan Barao", wins: 33, losses: 3, draws: 0, nc: 1, picture: "http://www.fighthubtv.com/wp-content/uploads/2012/12/barao.jpg")
r_lawler = Fighter.create(name: "Robbie Lawler", wins: 26, losses: 10, draws: 0, nc: 1)
j_hendricks = Fighter.create(name: "Johny Hendricks", wins: 17, losses: 3, draws: 0, nc: 0)
mizugaki = Fighter.create(name: "Takeyo Mizugaki", wins: 20, losses: 9, draws: 2, nc: 0)
f_rivera = Fighter.create(name: "Francisco Rivera", wins: 11, losses: 4, draws: 0, nc: 1)

Fightcard.delete_all
fc1 = Fightcard.create(promotion: "UFC", name: "UFC 173", city: "Las Vegas", state: "NV", country: "U.S.A.", date: "2014-5-24")
fc2 = Fightcard.create(promotion: "UFC", name: "UFC 181", city: "Las Vegas", state: "NV", country: "U.S.A.", date: "2014-12-6")

Judgescore.delete_all
s1 = Judgescore.create(judge_id: chris_lee.id, r1_1: 10, r2_1: 9, r3_1: 10, r4_1: 10, r1_2: 9, r2_2: 10, r3_2: 9, r4_2: 9, t1: 39, t2:37)
s2 = Judgescore.create(judge_id: tony_weeks.id, r1_1: 10, r2_1: 10, r3_1: 10, r4_1: 10, r1_2: 9, r2_2: 9, r3_2: 9, r4_2: 9, t1: 40, t2:36)
s3 = Judgescore.create(judge_id: derek_cleary.id, r1_1: 10, r2_1: 10, r3_1: 10, r4_1: 10, r1_2: 9, r2_2: 9, r3_2: 9, r4_2: 9, t1: 40, t2:36)
s4 = Judgescore.create(judge_id: sal.id, r1_1: 10, r2_1: 9, r3_1: 9, r4_1: 9, r5_1: 10, r1_2: 9, r2_2: 10, r3_2: 10, r4_2: 10, r5_2: 9, t1: 47, t2:48)
s5 = Judgescore.create(judge_id: marco.id, r1_1: 10, r2_1: 9, r3_1: 9, r4_1: 10, r5_1: 10, r1_2: 9, r2_2: 10, r3_2: 10, r4_2: 9, r5_2: 9, t1: 48, t2:47)
s6 = Judgescore.create(judge_id: glenn_t.id, r1_1: 10, r2_1: 10, r3_1: 9, r4_1: 10, r5_1: 10, r1_2: 9, r2_2: 9, r3_2: 10, r4_2: 9, r5_2: 9, t1: 49, t2:46)
s7 = Judgescore.create(judge_id: chris_lee.id, r1_1: 10, r2_1: 9, r3_1: 10, r1_2: 9, r2_2: 10, r3_2: 9, t1: 29, t2:28)
s8 = Judgescore.create(judge_id: roy_s.id, r1_1: 10, r2_1: 10, r3_1: 10, r1_2: 9, r2_2: 9, r3_2: 9, t1: 30, t2:27)
s9 = Judgescore.create(judge_id: glenn_t.id, r1_1: 10, r2_1: 10, r3_1: 10, r1_2: 9, r2_2: 9, r3_2: 9, t1: 30, t2:27)

Scorecard.delete_all
sc1 = Scorecard.create(fighter_1_id: tj.id, fighter_2_id: renan.id, j_1_score_id: s1.id, j_2_score_id: s2.id, j_3_score_id: s3.id, pic: "/ufc-173-dillashaw-barao-scorecards-big.jpg")
sc2 = Scorecard.create(fighter_1_id: r_lawler.id, fighter_2_id: j_hendricks.id, j_1_score_id: s4.id, j_2_score_id: s5.id, j_3_score_id: s6.id, pic: "/HendricksLawler2_scorecard.jpg")
sc3 = Scorecard.create(fighter_1_id: mizugaki.id, fighter_2_id: f_rivera.id, j_1_score_id: s7.id, j_2_score_id: s8.id, j_3_score_id: s9.id)


Fight.delete_all
Fight.create(fightcard_id: fc1.id, fight_num: 4, weightclass_id: bant.id, championship: 0, card_level:1, rounds_sch: 3, fighttime: 900, method: "Unanimous Decision", scorecard_id: sc3.id)
Fight.create(fightcard_id: fc1.id, fight_num: 1, card_level:1, weightclass_id: bant.id, championship: 1, rounds_sch: 5, fighttime: 1346, method: "TKO (head kick and punches)", scorecard_id: sc1.id)
Fight.create(fightcard_id: fc2.id, fight_num: 1, weightclass_id: welt.id, championship: 1, card_level:1, rounds_sch: 5, fighttime: 1500, method: "Split Decision", scorecard_id: sc2.id)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
