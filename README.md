# flask-uwsgi-nginx
Use Official Nginx Docker Image to build a uWSGI aware Flask Container

## Usage

there must be a `web_app/` folder that contains the flask app.

in `web_app` folder there must be:

- requirements.txt
- wsgi.py

and you must import your flask application as `web_app` in wsgi.py:

```python
import your_flask_app.app as web_app
```


