import requests
import json

save_to_path = 'ace_ids.txt'

def get_acelinks_ipfs():

    url = 'https://bafybeihaak6jp7c6y3weyynkfruefwtgchvx2uuppmtts775k4z7kyw4ny.ipfs.dweb.link?filename=index.html'

    '''
    # TOR USAGE. UNCOMMENT LINE INSIDE try/except BOLOCK:
    proxies = {
        'http': 'socks5h://localhost:9050',
        'https': 'socks5h://localhost:9050'
    }
    '''
    try:
        response = requests.get(url)
        # response = requests.get(url, proxies=proxies)
        response.raise_for_status()

    except requests.HTTPError as e:
        # Send your bot notification here
        print(f"IPFS ERROR: {e}")
        exit(1)

    print("IPFS Response Status:", response.status_code)
    content = response.content.decode('utf-8', errors='replace')  # Use UTF-8 encoding

    start_marker = "const linksData = "
    start_index = content.find(start_marker)

    if start_index != -1:
        start_index += len(start_marker)
        end_index = content.find('};', start_index) + 1  # Find the end of the JSON object

        if end_index != -1:
            json_data = content[start_index:end_index]
            links_data = json.loads(json_data)
            if not links_data["links"]:
                print("No links found in links_data.")
                exit(1)
            plain_text_list = []

            for link in links_data["links"]:
                if len(link["url"].replace("acestream://", "")) < 40:
                    continue
                plain_text_list.append(link["name"])
                #print(link["name"])
                plain_text_list.append(link["url"])
                #print(link["url"].replace("acestream://", ""))

            with open(save_to_path, 'w', encoding='utf-8') as file:
                for item in plain_text_list:
                    file.write(f"{item}\n")

            saved_link_count = len(plain_text_list) // 2
            print(f"{saved_link_count} enlaces acestream guardados desde IPFS")

    else:
        print("No links data found in the content.")
        exit(1)


get_acelinks_ipfs()
