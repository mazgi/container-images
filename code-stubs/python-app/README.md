### Run

```shellsession
pip install -e .[dev]
```

```shellsession
python -m mt_to_hugo_article_converter module
```

```shellsession
autopep8 --in-place --recursive .
```

### Test

```shellsession
pip install -e .[test]
```

```shellsession
python -m pytest --cov --pycodestyle module
```
