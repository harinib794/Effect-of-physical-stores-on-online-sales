# Casual effect of physical stores on online sales     
Designed a quasi-natural experiment for multichannel apparel and home goods retailer using transactional data to determine the casual effect of the firm's physical stores on online sales.    

# Introduction    
A multichannel apparel and home goods retailer suffered massive losses due to closure of its stores due to COVID-19 pandemic. The CEO of the company was contemplating whether to close the stores permanently or wait till economy revives. But it could be possible that online sales are highly interdependent with the stores.     

Objective: To determine the effect of stores on online purchase metrics.    

# Approach
Design quasi-natural experiment using past transaction data. Quasi-natural experiments do not involve random application of a treatment. Instead, a treatment is applied due to social or political factors, such as a change in laws or natural disasters. The recipients of the treatment are thus not randomly but intentionally chosen according to some predetermined criteria.   
In this case, new stores being opened is taken as the natural event. Six new stores were opened by the firm in year 200X.Data on all customer interactions for 4 years around 200x, two years prior and two years after 200X was provided. The distance of each customer from the nearest store was also provided. As a result of store openings, store distance reduced for approximately 17000 customers and it remained the same for 1.5 million remaining customers. The 17000 customers were taken as affected(treated) customers and 50,000 customers were randomly chosen from the 1.5 million customers as unaffected customers(control). Treatment being distance to nearest store affected by new store opening. The two group are then compared for treatment effect of stores opening using Difference in Difference (DID) and matching approach.    

# Data Dictionary:    
CustID:	Customer ID    
Treat:	Treatment indicator (Treat=1 for affected customer and =0 for unaffected customer     
IncCat:	Income category of the customer household [1: < $50K, 2: $50-$75K, 3: $75-$100K, 4: $100-$150K, 5: >$150K, and 6: unknown]     
AgeCat:	Age category of head of the customer household [1:< 25 Yrs, 2:25-34 Yrs, 3: 35-44 Yrs, 4: 45-54 Yrs, 5: 55-64 Yrs, 6: >65 Yrs, and 7: unknown]     
## Variables before store opening    
BefDist:	Distance from the nearest store for the customer before store opening (miles)    
PreTotalInt:	Total purchase interactions by the customer before store opening    
PreTotalPur:	Total purchase quantity for the customer before store opening     
PreTotalRev:	Total purchase revenue for the customer before store opening      
PreOnlineInt:	Number of Online purchase interactions for the customer before store opening     
PreOnlinePur:	Online purchase quantity for the customer before store opening      
PreOnlineRev:	Online purchase revenue (USD) for the customer before store opening    
PreStoreInt:	Number of Store purchase interactions for the customer before store opening    
PreStorePur:	Store purchase quantity for the customer before store opening    
PreStoreRev:	Store purchase revenue (USD) for the customer before store opening     
## Variables after store opening      
AftDist:	Distance from the nearest store for the customer after store opening (miles)     
PostOnlineInt:	Number of Online purchase interactions for the customer after store opening    
PostOnlinePur:	Online purchase quantity for the customer after store opening    
PostOnlineRev:	Online purchase revenue (USD) for the customer after store opening    
PostStoreInt:	Number of Store purchase interactions for the customer after store opening          
PostStorePur:	Store purchase quantity for the customer after store opening       
PostStoreRev:	Store purchase revenue (USD) for the customer after store opening    

# Conclusion
The metrics from data chosen to compare the two groups are online purchase interaction, online purchase quantity and online purchase revenue.It was inferred from the analysis that stores have a complimentary effect on online sales.Hence, it is recommended not to shut down the stores.     

For detailed analysis on DID approach refer to Effect_of_stores.pdf.    






