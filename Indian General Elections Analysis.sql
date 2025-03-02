--Total Nummber of Constituencies
select 
count (parliament_constituency) as total_seats
from constituencywise_results

--Total Number of Seats by States
select
s.state as state_name,
count (cr.parliament_constituency) as total_seats
from 
constituencywise_results cr
inner join statewise_results sr 
on cr.parliament_constituency = sr.parliament_constituency
inner join states s
on sr.state_id = s.state_id
group by s.state

--Total Seats Won NDA Alliance
select 
sum(case
when party IN (
'Bharatiya Janata Party - BJP', 
'Telugu Desam - TDP', 
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS', 
'AJSU Party - AJSUP', 
'Apna Dal (Soneylal) - ADAL', 
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS', 
'Janasena Party - JnP',
'Janata Dal  (Secular) - JD(S)',
'Lok Janshakti Party(Ram Vilas) - LJPRV', 
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD', 
'Sikkim Krantikari Morcha - SKM'
) 
then [Won]
else 0 
end) as NDA_Total_Seats_Won
from 
partywise_results

--Seatwise bifurcation of parties in NDA
select
Party as Party_Name, Won as Seats_Won_NDA
from
partywise_results
where
party in(
'Bharatiya Janata Party - BJP', 
'Telugu Desam - TDP', 
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS', 
'AJSU Party - AJSUP', 
'Apna Dal (Soneylal) - ADAL', 
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS', 
'Janasena Party - JnP', 
'Janata Dal  (Secular) - JD(S)',
'Lok Janshakti Party(Ram Vilas) - LJPRV', 
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD', 
'Sikkim Krantikari Morcha - SKM'
 )
order by Seats_Won_NDA desc

--Total seats won by I.N.D.I.A Alliance
select
sum(case
when party in(
'Indian National Congress - INC',
'Samajwadi Party - SP',
'All India Trinamool Congress - AITC',
'Dravida Munnetra Kazhagam - DMK',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Communist Party of India - CPI',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
'Communist Party of India  (Marxist) - CPI(M)',
'Indian Union Muslim League - IUML',
'Jammu & Kashmir National Conference - JKN',
'Aam Aadmi Party - AAAP',
'Jharkhand Mukti Morcha - JMM',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Rashtriya Janata Dal - RJD',
'Revolutionary Socialist Party - RSP',
'Rashtriya Loktantrik Party - RLTP',
'Viduthalai Chiruthaigal Katchi - VCK',
'Bharat Adivasi Party - BHRTADVSIP'
)
then won
else 0
end) as INDIA_Total_Seats_Won
from 
partywise_results

--Seatwise bifurcation of I.N.D.I.A. Alliance
select
Party as Party_Name, Won as Seats_Won_INDIA
from
partywise_results
where
party in(
'Indian National Congress - INC',
'Samajwadi Party - SP',
'All India Trinamool Congress - AITC',
'Dravida Munnetra Kazhagam - DMK',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Communist Party of India - CPI',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
'Communist Party of India  (Marxist) - CPI(M)',
'Indian Union Muslim League - IUML',
'Jammu & Kashmir National Conference - JKN',
'Aam Aadmi Party - AAAP',
'Jharkhand Mukti Morcha - JMM',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Rashtriya Janata Dal - RJD',
'Revolutionary Socialist Party - RSP',
'Rashtriya Loktantrik Party - RLTP',
'Viduthalai Chiruthaigal Katchi - VCK',
'Bharat Adivasi Party - BHRTADVSIP'
) 
order by Seats_Won_INDIA desc

--Add new column in partywise results, stating which alliance the party belongs to
alter table partywise_results
add Alliance varchar(50)

update partywise_results
set alliance = 'I.N.D.I.A'
where party in(
'Indian National Congress - INC',
'Samajwadi Party - SP',
'All India Trinamool Congress - AITC',
'Dravida Munnetra Kazhagam - DMK',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Communist Party of India - CPI',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
'Communist Party of India  (Marxist) - CPI(M)',
'Indian Union Muslim League - IUML',
'Jammu & Kashmir National Conference - JKN',
'Aam Aadmi Party - AAAP',
'Jharkhand Mukti Morcha - JMM',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Rashtriya Janata Dal - RJD',
'Revolutionary Socialist Party - RSP',
'Rashtriya Loktantrik Party - RLTP',
'Viduthalai Chiruthaigal Katchi - VCK',
'Bharat Adivasi Party - BHRTADVSIP'
) 
update partywise_results
set alliance = 'NDA'
where party in(
'Bharatiya Janata Party - BJP', 
'Telugu Desam - TDP', 
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS', 
'AJSU Party - AJSUP', 
'Apna Dal (Soneylal) - ADAL', 
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS', 
'Janasena Party - JnP', 
'Janata Dal  (Secular) - JD(S)',
'Lok Janshakti Party(Ram Vilas) - LJPRV', 
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD', 
'Sikkim Krantikari Morcha - SKM'
)
update partywise_results
set alliance = 'Other'
where alliance  is NULL

select alliance,
sum(won) as Seats_Won
from partywise_results
group by alliance
order by Seats_Won desc

-- Winning Candidates name, party name, total votes, margin of victory, state name and constituency name
select
cr.winning_candidate,
pr.party,
pr.alliance,
cr.total_votes,
cr.margin,
s.state,
cr.constituency_name
from constituencywise_results cr
inner join partywise_results pr on cr.party_id = pr.party_id
inner join statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
inner join states s on sr.state_id = s.state_id
where cr.constituency_name = 'Kalyan'

--Distribution of EVM and Postal votes in a particular constituency
select
cd.evm_votes,
cd.postal_votes,
cd.total_votes,
cd.candidate,
cd.party,
cr.constituency_name
from constituencywise_results cr
inner join constituencywise_details cd on cr.Constituency_ID = cd.Constituency_ID
where cr.Constituency_Name = 'Kalyan'

--Which Parties won most seats in a state and how many seats
select
pr.party,pr.alliance,
count(cr.constituency_name) as seats_won
from constituencywise_results cr
inner join partywise_results pr on cr.Party_ID = pr.Party_ID
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on sr.state_ID = s.state_ID
where s.state = 'Maharashtra'
group by pr.alliance, pr.party
order by seats_won desc

--Statewise Alliance breakup
select 
s.state,
sum(case when pr.alliance = 'NDA' then 1 else 0 end) as NDA_Seats_Won,
sum(case when pr.alliance = 'I.N.D.I.A' then 1 else 0 end) as INDIA_Seats_Won,
sum(case when pr.alliance = 'OTHERS' then 1 else 0 end) as Others_Seats_Won
from partywise_results pr
inner join constituencywise_results cr on pr.party_ID = cr.party_ID
inner join statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
inner join states s on sr.state_id = s.state_id
where s.state = 'Maharashtra'
group by s.state

--Highest Number of EVM Votes
select top 10
cd.candidate,
cd.party,
cd.evm_votes,
cd.constituency_id,
cr.Constituency_Name
from constituencywise_details cd
inner join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
where
cd.EVM_Votes = (
                select max (cd1.evm_votes)
                from constituencywise_details cd1
			    where cd1.constituency_ID = cd.constituency_ID
				)
order by cd.evm_votes desc;

--Find the winning and runner up candidate in each constituency
with RankedCandidates as (
select
cd.Constituency_ID,
cd.Candidate,
cd.Party,
cd.EVM_Votes,
cd.Postal_Votes,
cd.EVM_Votes + cd.Postal_Votes as Total_Votes,
row_number() over (partition by cd.Constituency_ID order by cd.EVM_Votes + cd.Postal_Votes desc) as VoteRank
from
constituencywise_details cd
inner join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
inner join statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s ON sr.State_ID = s.State_ID
where s.State = 'Maharashtra'
)
select 
cr.Constituency_Name,
max(case when rc.VoteRank = 1 then rc.Candidate end) as Winning_Candidate,
max(case when rc.VoteRank = 2 then rc.Candidate end) as Runnerup_Candidate
from
RankedCandidates rc
inner join constituencywise_results cr on rc.Constituency_ID = cr.Constituency_ID
group by cr.Constituency_Name
order by cr.Constituency_Name

