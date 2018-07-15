# IsItFreeze

Small web utility made for integration in deployment tool, to check whether a given date allows deployment. Deployment is not allowed on 'Freeze' days. Freeze is defined as follows:  
>There is a freeze 3 working days before, and 2 working days after, months end. Additionally, january has an arbitrary length   freeze. As such, the entire month is labeled as frozen for safe automation.*

## API
**Current date**
- https://is-it-freeze.herokuapp.com/ 

**Specific date**
- https://is-it-freeze.herokuapp.com/2018/01/31
