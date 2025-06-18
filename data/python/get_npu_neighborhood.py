from bs4 import BeautifulSoup as soup
npu_links_selector = "#ctl00_content_Screen p:nth-child(1) a"

with open("neighborhood-by-npu.html", "r") as f:
    html_doc = "".join(x.strip() for x in f.readlines())

soup = BeautifulSoup(html_doc, 'html.parser')

# Find the paragraph containing NPU A
npu_a_paragraph = soup.find('a', {'name': 'A'}).find_parent('p')

# Split by <br> tags and clean up
neighborhoods = []
for br in npu_a_paragraph.find_all('br'):
    br.replace_with('\n')

text_content = npu_a_paragraph.get_text()
neighborhoods = [n.strip() for n in text_content.split('\n') if n.strip() and n.strip() != 'A']