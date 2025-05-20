# Wrapper module that maintains backward compatibility
# This file now imports from the extracted llm-integration module

import sys
sys.path.append('/home/z/repos/llm-integration')  # Add extracted module directory to path
from openai_query import ask_gpt
# No other changes needed - the original function is now re-exported
