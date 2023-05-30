from pmaw import PushshiftAPI
import pandas as pd
import sys

api = PushshiftAPI(file_checkpoint=10)
search_word = sys.argv[1]
comments = api.search_comments(q=search_word, subreddit="gameofthrones", limit=500, mem_safe=True)
comments_list = [c for c in comments]

comments_df = pd.DataFrame(comments_list)

output_file = "{}.csv"
comments_df.to_csv(output_file.format(sys.argv[2]), index=False)