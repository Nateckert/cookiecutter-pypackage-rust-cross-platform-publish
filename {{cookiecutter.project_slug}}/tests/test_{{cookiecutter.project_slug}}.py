#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
test_{{ cookiecutter.project_slug }}
----------------------------------

Tests for `{{ cookiecutter.project_slug }}` module.
"""

{% if cookiecutter.use_pytest == 'y' -%}
import pytest
{% else %}
import sys
import unittest
{%- endif %}
{%- if cookiecutter.command_line_interface|lower == 'click' %}
from click.testing import CliRunner
{%- endif %}

from {{ cookiecutter.project_slug }} import {{ cookiecutter.project_slug }}
{%- if cookiecutter.command_line_interface|lower == 'click' %}
from {{ cookiecutter.project_slug }} import cli
{%- endif %}


{% if cookiecutter.use_pytest == 'y' -%}
@pytest.fixture
def response():
    """Sample pytest fixture.
    See more at: http://doc.pytest.org/en/latest/fixture.html
    """
    # import requests
    # return requests.get('https://github.com/audreyr/cookiecutter-pypackage')


def test_content(response):
    """Sample pytest test function with the pytest fixture as an argument.
    """
    # from bs4 import BeautifulSoup
    # assert 'GitHub' in BeautifulSoup(response.content).title.string


def test_{{ cookiecutter.project_slug }}():
    assert {{ cookiecutter.project_slug }}.rust_lib.is_prime(12) is 0
    assert {{ cookiecutter.project_slug }}.rust_lib.is_prime(13) is 1
{%- if cookiecutter.command_line_interface|lower == 'click' %}


def test_command_line_interface():
    runner = CliRunner()
    result = runner.invoke(cli.main)
    assert result.exit_code == 0
    assert 'Please supply an integer argument ' in result.output
    help_result = runner.invoke(cli.main, ['--help'])
    assert help_result.exit_code == 0
    print(help_result.output)
    assert '--help  Show this message and exit.' in help_result.output
    non_prime_result = runner.invoke(cli.main, ['12'])
    assert non_prime_result.output.strip() == "False"
    prime_result = runner.invoke(cli.main, ['13'])
    assert prime_result.output.strip() == "True"
{%- endif %}
{% else %}
class Test{{ cookiecutter.project_slug|title }}(unittest.TestCase):

    def setUp(self):
        pass


    def tearDown(self):
        pass


    def test_000_something(self):
        pass


    def test_{{ cookiecutter.project_slug }}():
        assert {{ cookiecutter.project_slug }}.rust_lib.is_prime(12) is 0
        assert {{ cookiecutter.project_slug }}.rust_lib.is_prime(13) is 1


{% if cookiecutter.command_line_interface|lower == 'click' %}
    def test_command_line_interface(self):
        runner = CliRunner()
        result = runner.invoke(cli.main)
        assert result.exit_code == 0
        assert 'Please supply an integer argument ' in result.output
        help_result = runner.invoke(cli.main, ['--help'])
        assert help_result.exit_code == 0
        print(help_result.output)
        assert '--help  Show this message and exit.' in help_result.output
        non_prime_result = runner.invoke(cli.main, ['12'])
        assert non_prime_result.output.strip() == "False"
        prime_result = runner.invoke(cli.main, ['13'])
        assert prime_result.output.strip() == "True"

{%- endif %}
{%- endif %}