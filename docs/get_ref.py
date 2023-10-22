from scholarly import scholarly
search_query = scholarly.search_pubs("""T. Bogodorova, L. Vanfretti, and K. Turitsyn. 2015. Bayesian Parameter Estimation
of Power System Primary Frequency Controls under Modeling Uncertainties.
IFAC-PapersOnLine 48, 28 (2015), 461–465.""")
search_result = next(search_query)
print(search_result['bib'])

search_query = scholarly.search_pubs("""
Greg Brockman, Vicki Cheung, Ludwig Pettersson, Jonas Schneider, John Schulman, Jie Tang, and Wojciech Zaremba. 
2016. Openai gym. arXiv preprint arXiv:1606.01540 (2016).""")
search_result = next(search_query)
print(search_result['bib'])
