# Project that parses a language given a grammar and outputs its graph representation
from abc import ABC, abstractmethod
import sys


class Node:
    def __init__(self, value):
        self.value = value
        self.children = []

    def __str__(self):
        # Convert each child to a string and store in a list
        child_strings = [str(child) for child in self.children]

        # Return the string representation of the object and its children
        return f"{self.value} -> {child_strings}"

    def add_child(self, node):
        self.children.append(node)


class GrammarRule(ABC):
    @classmethod
    def evaluate(cls, input):
        # Check if the input matches the grammar rule
        if cls.evaluation_function(input):
            # If it does, convert the input and return
            return cls.conversion_function(input)
        else:
            # If it doesn't, raise an exception
            raise Exception(f"Input {input} does not match grammar rule {cls.__name__}")

    @abstractmethod
    def evaluation_function(string) -> bool:
        pass

    @abstractmethod
    def conversion_function(string) -> Node:
        pass


class B(GrammarRule):
    @staticmethod
    def evaluation_function(string) -> bool:
        return string == "b" or string == "bc"

    @staticmethod
    def conversion_function(string) -> Node:
        return_value = Node("B")

        # Check if string is "bc"
        if string == "bc":
            # Add children "b" and "c" to return value
            return_value.add_child(Node("b"))
            return_value.add_child(Node("c"))
        # Check if string is "b"
        elif string == "b":
            # Add child "b" to return value
            return_value.add_child(Node("b"))

        return return_value


class S(GrammarRule):
    @staticmethod
    def evaluation_function(string) -> bool:
        return string[0] == "a" and string[-1] == "c"

    @staticmethod
    def conversion_function(string) -> Node:
        return_value = Node("S")

        # Add a child Node with value "a"
        return_value.add_child(Node("a"))

        # Extract the string between the first and last characters
        B_string = string[1:-1]

        # Evaluate the extracted string and add the result as a child Node
        B_node = B.evaluate(B_string)
        return_value.add_child(B_node)

        # Add a child Node with value "c"
        return_value.add_child(Node("c"))

        return return_value


class DigraphFormatter:
    @staticmethod
    def format(node):
        # Convert the node to a Graphviz string
        relations = [
            f'"{parent}" -> "{child}"'
            for parent, child in DigraphFormatter.get_relationships(node)
        ]
        relations_string = "\n".join(relations)
        return f"digraph G {{\n{relations_string}\n}}"

    @staticmethod
    def get_relationships(node):
        nodes_to_visit = [node]
        current_node = 0
        relationships = []
        unique_nodes = set()
        while current_node < len(nodes_to_visit):
            node = nodes_to_visit[current_node]
            current_node += 1
            for child in node.children:
                child_value = child.value
                while child_value in unique_nodes:
                    child_value += "'"
                unique_nodes.add(child_value)
                relationships.append((node.value, child_value))
                nodes_to_visit.append(child)
        return relationships


def main():
    args = sys.argv[1:]
    inp = args[0] if len(args) > 0 else input("Input: ")
    try:
        print(f"Input: {inp}")
        res = S.evaluate(inp)
        print(DigraphFormatter.format(res))
    except Exception as e:
        print(e)
    print()


if __name__ == "__main__":
    main()
