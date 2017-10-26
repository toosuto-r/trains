\z 1
\t 1000

cyc:120

st:(!). value flip .j.k[raze read0`:stations.json]`stations

cron:([]time:();action:();args:())
trains:([] name:();time:();headcode:();uid:();depart:();arrive:();exparrive:();expdepart:();status:();delay:())

gs:{
  frs:(fr:.j.k[raze system"sh getstation.sh ",x][`StationBoard])`Service;
  if[99h=type frs;frs:flip enlist'[frs]];
  if[not count frs;:()];
  r:.Q.id frs;
  o:update 
    name:`$fr`$"@name" 
    time:(first sum("D V";10 1 8)0:enlist fr[`$"@Timestamp"])
    from select 
      headcode:`$Headcode,
      uid:"I"$Uid,stype:`$ServiceType[;`$"@Type"],
      depart:sum ("DV";8 6)0:DepartTime[;`$"@timestamp"],
      arrive:sum ("DV";8 6)0:DepartTime[;`$"@timestamp"],
      exparrive:`$ExpectedArriveTime[;`$"@time"]except\:" ",
      expdepart:`$ExpectedDepartTime[;`$"@time"]except\:" ",
      status:`$ServiceStatus[;`$"@Status"]except\:" ",
      delay:"I"$Delay[;`$"@Minutes"] 
    from r;
  `trains insert o;
  }

.z.ts:{pi:exec i from cron where time<.z.P;if[count pi;r:exec action,args from cron where i in pi;delete from `cron where i in pi;({value[x]. (),y}.)'[flip value r]];}

gettrains:{`cron insert (.z.P+"v"$cyc;gettrains;`);gs'[key st]}

wd:{.Q.dpft[`:hdb;.z.D;`name;`trains];`cron insert((1+.z.D)+23:59:59.000;wd;`);}

