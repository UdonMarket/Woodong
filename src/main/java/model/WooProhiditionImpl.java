package model;

import java.util.List;

public interface WooProhiditionImpl {
	public List<String> selectProhiditionList();
	
	public void addProhidition(String prohidition);
	
	public void deleteProhidition();
}
