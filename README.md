# Women, Business, and the Law: A Case for Better Data Collection
## Overview of Paper

This repo includes all files needed to reproduce the paper "Gendered Laws and Women in the Workforce" published in the American Economics Review: Insights. It reproduces the graphs from the aforementioned paper using data from the World Bank's Women, Business and the Law Database. Additionally, it applies a Canadian-facing lens by cross-referencing the data with statistics available from Statistics Canada. While the World Bank's WBL index provides a valuable snapshot of legal frameworks, our analysis emphasizes the importance of complementing such indices with empirical data to gain a more holistic understanding. We hope to inspire future research that could explore the intersections of legal provisions, their implementation, and their impact on the lived experiences of individuals, especially concerning gender equality in the workplace.

## File Structure

The repository is structured as follows:

-   `input/data` contains the data sources used in analysis including the raw data.
-   `outputs/data` contains the cleaned dataset that was constructed.
-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Reproducing Graphs and Tables 

Here is a quick guide to reproducing the graphs and tables.
1. Clone this repository to your computer
2. Download the data from the replication package folder
3. Clean it using data cleaning file in scripts
4. Open the paper.qmd file in outputs to test the R code that generated the plots

Reproduction DOI: https://doi.org/10.48152/ssrp-qeab-5493

## Notes: 

My folder structure and workflow is based on one created by the legendary Rohan Alexander, available at https://github.com/RohanAlexander/starter_folder
### LLM Usage Disclosure: Aspects of our R code and paper were written and edited with the assistance of Large Language Models, in particular Claude-2 and GPT-4 (Microsoft Copilot). The chat history with both models are available in inputs/copilot.txt

