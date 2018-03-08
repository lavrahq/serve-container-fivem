import requests
import bs4

# Page to look for list of builds
fivem_master_url = "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master"

# Fetch the builds page
page_response = requests.get(fivem_master_url)

# Raise an exception if the request does not succeed
page_response.raise_for_status()

# Parse the page as HTML
page_parsed = bs4.BeautifulSoup(page_response.text, "html.parser")

# Get the latest build ID by finding all anchor tags, getting the text of the last one,
# then stripping the trailing slash from it
latest_build = page_parsed.find_all("a")[-1].text.rstrip("/")

# Get the build number by getting the section of the string before the dash
latest_build_num = latest_build.split("-")[0]

# Create a full URL by concatenating the master URL, the build ID, and then the archive name
latest_build_url = "{0}/{1}/fx.tar.xz".format(fivem_master_url, latest_build)

# Prints the latest build ID before exiting
print(latest_build)

