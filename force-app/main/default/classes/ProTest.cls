public virtual class ProTest {
    public integer count = 0;
    	public integer isRequiredPlantChange(){
				count = count + 1;  //Plant Change Logic
			System.debug('inside' + count);
		return count;
	}
  //system.debug('outside' +count);
}