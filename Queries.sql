-- Query - 1 - Retrieve list of companies along with their locations  (Do Not display companies that do not have any locations)
Select C.Name CompanyName,L.Name LocationName, A.AddressOne + ',' + A.City + ', ' + A.State + ', ' + A.Zip LocationAddress
From Companies C
inner Join Locations L on C.Id=L.CompanyId
inner Join Addresses A on L.AddressId=A.Id
Order By C.Name,L.Name

-- Query - 2 - Retrieve list of companies along with their locations and employee count   (Ensure that companies that do not yet have any employees are displayed as well)
Select C.Name CompanyName,L.Name LocationName,COUNT(E.Id) NumberOfEmployees
From Companies C
left Join Locations L on C.Id=L.CompanyId
left Join Employment E on L.Id=E.LocationId
Group By  C.Name,L.Name
Order By C.Name,L.Name

-- Query - 3 - Retrieve list of companies along with their location name and ACTIVE employee count 
Select C.Name CompanyName,L.Name LocationName,COUNT(E.Id) NumberOfEmployees
From Companies C
left Join Locations L on C.Id=L.CompanyId
left Join Employment E on L.Id=E.LocationId
WHERE getdate() BETWEEN E.StartDate AND COALESCE(E.EndDate, getDate()+1)
Group By  C.Name,L.Name
Order By C.Name,L.Name

-- Query - 4 - Retrieve list of employees that are 21 years or older at Facebook
select E.FirstName + ' ' + E.LastName FullName,datediff(year,E.BirthDate,getdate()) Age
From Companies C
left join Locations L on C.Id=L.CompanyId
left join Employment EM on L.Id=EM.LocationId
left join Employees E on EM.EmployeeId=E.Id
WHERE  C.Name='Facebook'
AND DATEADD(YEAR, 21, E.Birthdate) <= getdate()

-- Query - 5 - Retrieve list age of oldest employee in each company across all campuses/locations
Select C.Name CompanyName,datediff(year,Min(BirthDate),getdate()) Age
From Companies C
left join Locations L on C.Id=L.CompanyId
left join Employment EM on L.Id=EM.LocationId
left join Employees E on EM.EmployeeId=E.Id
Group By C.Name
Order By C.Name
