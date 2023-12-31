package org.openxava.calculators;

import org.openxava.util.*;

/**
 * Birth date year of the current user. <p>
 * 
 * @author Javier Paniza
 */

public class CurrentUserBirthDateYearCalculator implements ICalculator {

	public Object calculate() throws Exception {
		UserInfo user = Users.getCurrentUserInfo();
		return user.getBirthDateYear();
	}
	
}
