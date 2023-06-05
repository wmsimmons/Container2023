import json

from flask import Flask, render_template, jsonify

import oyaml as yaml

align_resume_app = Flask(__name__, template_folder="./templates")
align_resume_app.config['JSON_SORT_KEYS'] = False


@align_resume_app.route('/')
def index():
    website_data = yaml.load(open('_config.yaml'))

    return render_template("index.html", data=website_data)


@align_resume_app.route('/resume', methods=['GET'])
def get_all_words():
    source_file = 'resume.json'

    json_output = json.load(open(source_file))

    return jsonify({'result': json_output})


if __name__ == '__main__':
    align_resume_app.run(debug=True, port=5000)
