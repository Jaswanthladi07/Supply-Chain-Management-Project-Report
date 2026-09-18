-- Total Orders
SELECT COUNT(Product_ID) AS Total_Orders FROM supply_chain_combined;

-- Total Revenue
SELECT SUM(Unit_Price) AS Total_Revenue FROM supply_chain_combined;

-- Average Order Value
SELECT SUM(Unit_Price) / COUNT(Product_ID) AS Avg_Order_Value FROM supply_chain_combined;

-- Profit & Margin
SELECT SUM(Unit_Price - Unit_Cost) AS Total_Profit,
       (SUM(Unit_Price - Unit_Cost) / SUM(Unit_Price)) * 100 AS Profit_Margin_Percent
FROM supply_chain_combined;
CREATE OR REPLACE VIEW mydb.kpi_dashboard_final AS
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    Category,
    Sub_Category,
    Warehouse_Region,
    Supplier_Tier,
    
    -- Order & Sales KPIs
    COUNT(Product_ID) AS Total_Orders,
    SUM(Unit_Price) AS Total_Revenue,
    SUM(Unit_Price - Unit_Cost) AS Total_Profit,
    (SUM(Unit_Price - Unit_Cost) / SUM(Unit_Price)) * 100 AS Profit_Margin_Percent,
    (SUM(Unit_Price) / COUNT(Product_ID)) AS Avg_Order_Value,
    
    -- Supplier KPIs
    COUNT(DISTINCT Supplier_ID) AS Total_Suppliers,
    AVG(Reliability_Score) AS Avg_Supplier_Reliability,
    
    -- Warehouse KPIs
    COUNT(DISTINCT Warehouse_ID) AS Total_Warehouses,
    SUM(Capacity_Units) AS Total_Warehouse_Capacity,
    
    -- Customer KPIs
    COUNT(DISTINCT Customer_ID) AS Total_Customers
    
FROM mydb.supply_chain_combined
GROUP BY 
    Year, Month, Category, Sub_Category, Warehouse_Region, Supplier_Tier
ORDER BY 
    Year, Month, Category, Sub_Category, Warehouse_Region, Supplier_Tier;
SELECT * FROM mydb.kpi_dashboard_final;
