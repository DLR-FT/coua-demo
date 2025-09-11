import pytest

from malkoha import trace_requirements


@trace_requirements("hello.low.1")
def add(left, right):
    return left + right

@trace_requirements("hello.low.1")
def test_add(record_property):
    record_property("requirement", "hello.low.1")
    assert 10 == add(5, 5)
