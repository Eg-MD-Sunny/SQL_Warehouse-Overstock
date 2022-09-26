---- OverStock Report (Warehouse wise)

SELECT pv.id
	,pv.name
	,SUM(cws.requiredstock) RequiredStock
	,SUM(cws.shelved) + SUM(cws.markedforrecall) Stocknow
	,w.Id [WarehouseId]
	,w.name [Warehouse Name]-- global

FROM CurrentWarehouseStock cws
JOIN productvariant pv ON pv.id = cws.ProductVariantId
JOIN Warehouse w ON w.id = cws.WarehouseId
JOIN ProductVariantPricing PVP ON pvp.ProductVariantId = pv.Id
WHERE pv.deleted = 0
    --AND PVP.MetropolitanAreaId = 1		-- DHA OverStock Report	-- DHA > 1, CTG > 2, JSR > 3
	--AND w.MetropolitanAreaId=1		-- DHA OverStock Report	-- DHA > 1, CTG > 2, JSR > 3
	and  PVP.MetropolitanAreaId is null--global
	AND pv.name NOT LIKE '%Gift From Chaldal%'
	AND pv.Name NOT LIKE '%Shopping Bag%'
	AND pv.Name NOT LIKE '%Poly Bag%'
	AND pv.Name NOT LIKE '%GP %'
	AND CostPrice IS NOT NULL
	AND pv.shelftype in (9)
	AND pv.DistributionNetworkId = 1

	
GROUP BY pv.id
	,pv.name
	,w.Id
	,w.name--global


HAVING SUM(cws.requiredstock) < SUM(cws.shelved) + SUM(cws.markedforrecall)
--ORDER BY 11 ASC



---- OverStock Report( AFTER VLOOKUP)

SELECT pv.id
	,pv.name
	,SUM(cws.requiredstock) RequiredStock
	,SUM(cws.shelved) + SUM(cws.markedforrecall) Stocknow
	,w.Id [WarehouseId]
	,w.name [Warehouse Name]


FROM CurrentWarehouseStock cws
JOIN productvariant pv ON pv.id = cws.ProductVariantId
JOIN Warehouse w ON w.id = cws.WarehouseId
JOIN ProductVariantPricing PVP ON pvp.ProductVariantId = pv.Id
WHERE pv.deleted = 0
    AND PVP.MetropolitanAreaId is null
	and w.MetropolitanAreaId=1
	AND pv.name NOT LIKE '%Gift From Chaldal%'
	AND pv.Name NOT LIKE '%Shopping Bag%'
	AND pv.Name NOT LIKE '%Poly Bag%'
	AND pv.Name NOT LIKE '%GP %'
	AND CostPrice IS NOT NULL
	--AND pv.shelftype in (9)
	--AND pv.DistributionNetworkId = 1

	and pv.id in ()

GROUP BY pv.id
	,pv.name
	,w.Id
	,w.name
HAVING SUM(cws.requiredstock) < SUM(cws.shelved) + SUM(cws.markedforrecall)
--ORDER BY 11 ASC

