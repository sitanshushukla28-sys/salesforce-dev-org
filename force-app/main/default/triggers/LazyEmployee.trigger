trigger LazyEmployee on Case (after insert) {
  List<Case> newCases = new List<Case>();
  for (Case a : Trigger.new) {
    a.Status = 'Closed';
    //a.Owner  = 'David Liu';
    newCases.add(a);
  }
  update newCases;
}