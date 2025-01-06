# Association-Rule-Mining
This project delivers an interactive Shiny application for performing Association Rule Mining using the Apriori algorithm.

Objectives:
• Enable users to upload transaction datasets in either basket or binary format.
• Provide an interactive UI for adjusting Apriori algorithm parameters (support, confidence, and minimum rule length).
• Generate and display association rules dynamically based on user input.
• Allow exploratory data analysis (EDA) with transaction summaries, frequency plots, and rule insights.
• Offer static and interactive visualizations of the generated rules for better interpretation and presentation.
• Enable users to filter and sort rules based on metrics like lift, confidence, and support.

Key Features:
1. Data Upload and Transformation:
  • Supports basket and binary transaction datasets.
  • Automatically transforms binary datasets into a transaction matrix.

2. Apriori Algorithm Customization:
  • Dynamic sliders for Support Threshold, Confidence Threshold, and Minimum Rule Length.
  • Customizable parameters to refine rule generation.

3. Rule Exploration:
  • Display association rules in an interactive table (DT).
  • Filter and sort rules based on metrics.

4. Visualization Tools:
  • Static Plots: Visualize rules with scatterplots showing support, lift, and confidence.
  • Interactive Plots: Drill down into specific rules for detailed analysis.

5. Dynamic Summaries:
  • Real-time textual summaries of generated rules.
  • Insights into frequent item sets and patterns.

Technical Specifications:
• Frontend: Shiny (R)
• Backend: Apriori Algorithm (arules Package)
• Visualization Libraries: arulesViz, DT
• Data Formats Supported: Basket, Binary Transaction CSV

Deployment Environment:
• Local Deployment: Shiny Server or RStudio
• Cloud Deployment: shinyapps.io or custom Shiny server environment

Use Cases:
1. Retail Analysis: Discover frequently purchased item sets.
2. Market Basket Analysis: Recommend complementary products.
3. Movie Recommendations: Suggest movies based on user watch history.
4. Customer Segmentation: Identify common purchase behaviors.


Project Deployment: https://mominashkh.shinyapps.io/AssociationRuleMining/
