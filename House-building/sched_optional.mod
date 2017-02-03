// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

/* ------------------------------------------------------------

Problem Description
-------------------

This is a problem of building five houses. The masonry, roofing,
painting, etc. must be scheduled. Some tasks must necessarily take
place before others and these requirements are expressed through
precedence constraints.

There are three workers, and each worker has a given non-negative
skill level for each task.  Each task requires one worker that will
have to be selected among the ones who have a non null skill level for
that task.  A worker can be assigned to only one task at a time.  Each
house has a deadline. The objective is to maximize the skill levels of
the workers assigned to the tasks while respecting the deadlines.

------------------------------------------------------------ */

using CP;

tuple TPlanning{
   int nbHouses;
   int deadline;
}
TPlanning Planning = ...;
range Houses = 1..Planning.nbHouses;

{string} Workers = ...;

tuple TTask {
   key string name;
   int duration;
}
{TTask} Tasks = ...;

tuple TSkill {
  key string worker;
  key string task;
  int    level;  
};
{TSkill} Skills = ...;

tuple Precedence {
  key string pre;
  key string post;
};
{Precedence} Precedences = ...;

tuple Continuity {
  string worker;
  string task1;  
  string task2;
};
{Continuity} Continuities = ...;

tuple TTAskPrecedence {
 TTask beforeTask;
 TTask afterTask;
}

{TTAskPrecedence} TaskPrecedences =
 { <t1,t2> | t1, t2 in Tasks : <t1.name, t2.name> in Precedences};

dvar interval tasks [h in Houses][t in Tasks] in 0..Planning.deadline size t.duration;
dvar interval wtasks[h in Houses][s in Skills] optional;

execute {
		cp.param.FailLimit = 10000;
}

maximize sum(h in Houses, s in Skills) s.level * presenceOf(wtasks[h][s]);
subject to {
  forall(h in Houses) {
    // Temporal constraints
    forall(p in TaskPrecedences)
      endBeforeStart(tasks[h][p.beforeTask], tasks[h][p.afterTask]);  
    // Alternative workers  
    forall(t in Tasks)
      alternative(tasks[h][t], all(s in Skills: s.task==t.name) wtasks[h][s]);   
    // Continuity constraints
    forall(c in Continuities,
           <c.worker, c.task1, l1> in Skills, 
           <c.worker, c.task2, l2> in Skills)
      presenceOf(wtasks[h,<c.worker, c.task1, l1>]) == 
      presenceOf(wtasks[h,<c.worker, c.task2, l2>]);
  }
  // No overlap constraints
  forall(w in Workers)
    noOverlap(all(h in Houses, s in Skills: s.worker==w) wtasks[h][s]);
};

tuple THousePlan {
  int	house;
  TTask task;
  int	startDate;
  int	endDate;
}
{THousePlan} constructionPlan;

tuple TWorkerPlan {
  TSkill	skill;
  int	house;
  int	startDate;
  int	endDate;
}
{TWorkerPlan} workerPlan;

execute {
  constructionPlan.clear();
  for (var h in Houses) {
    for (var t in Tasks) {
      if (Opl.presenceOf(tasks[h][t])) {
        writeln("House: ", h, " --> Task: ", t.name, " - start: ", Opl.startOf(tasks[h][t]), " ; end: ", Opl.endOf(tasks[h][t]));
        constructionPlan.addOnly(h, t, Opl.startOf(tasks[h][t]), Opl.endOf(tasks[h][t]));
      }
    }
  }

  workerPlan.clear();
  for (var s in Skills) {
	for (h in Houses) {
      if (Opl.presenceOf(wtasks[h][s])) {
        writeln("Worker: ", s.worker, " --> House: ", h, ", Task: ", s.task, " - start: ", Opl.startOf(wtasks[h][s]), " ; end: ", Opl.endOf(wtasks[h][s]));
        workerPlan.addOnly(s, h, Opl.startOf(wtasks[h][s]), Opl.endOf(wtasks[h][s]));
      }
    }
  }
}
