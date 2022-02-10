from swiplserver import PrologMQI, PrologThread

with PrologMQI() as mqi:
    with mqi.create_thread() as prolog_thread:
        result = prolog_thread.query("member(X, [first, second, third]).")
        print(result)