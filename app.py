import json
from datetime import datetime

from flask import Flask, render_template, jsonify

import oyaml as yaml

app = Flask(__name__, template_folder="./templates")
app.config['JSON_SORT_KEYS'] = False


@app.route('/')
def index():
    #and the access its now method simpler
    d1 = str(datetime.now())
    website_data = yaml.safe_load(open('_config.yaml'))

    return render_template("index.html", data=website_data, value = d1)


@app.route('/resume', methods=['GET'])
def get_all_words():
    source_file = 'resume.json'

    json_output = json.load(open(source_file))

    return jsonify({'result': json_output})


if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True, port=5000)