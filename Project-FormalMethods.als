//SIGNATURES
abstract sig Organization{}
abstract sig Department{}
one sig CivilRegistrationOffice extends Organization{
Department1 : one MarriegeDepartment,
Department2 : one BirthDepartment,
Department3 : one DeathDepartment
}
one sig MarriegeDepartment extends Department{
MR : some MarriageRecord,
}
one sig DeathDepartment extends Department{
DR : some DeathRecord,
}
one sig BirthDepartment extends Department{
BR : some BirthRecord,
}

abstract sig date{}{
this in (Record.id + Record.date)
}
abstract sig id{}{
this in (Record.id + Record.date)
}
abstract sig Record{
date : disj one date,
id : disj one id,

}
abstract sig Person{
ID : disj one id
}
abstract sig BirthRecord extends Record{
father : one male,
mother : one female,
//BDepartment : one BirthDepartment
}{
father != mother
}
sig male extends Person{}{
this in (BirthRecord.father)
}
sig female extends Person{}{

this in (BirthRecord.mother)
}
abstract sig DeathRecord extends Record{
//DDepartment : DeathDepartment
}
abstract sig MarriageRecord extends Record {
spouse : Person,
//MDepartment : MarriegeDepartment
}
//FACTS

fact SpouseShouldBeDiffrent{
all m1,m2 : MarriageRecord | m1!=m2 =>
m1.spouse !=m2.spouse
}
// Predicates
pred FatherAndMotherAreDiffrent{
all b1,b2 : BirthRecord | b1 != b2 => b1.father != b2.father and 
b1.mother != b2.mother
}
pred show{}
run  show for  4
