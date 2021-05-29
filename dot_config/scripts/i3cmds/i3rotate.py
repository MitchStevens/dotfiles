import i3
from typing import List

class Window:
    def __init__(self, tree):
        self.id = tree['id']
        self.name = tree['name']
        self.window = tree['window']
        self.window_properties = tree['window_properties']

    def __repr__(self):
        return self.name

def is_window(tree) -> bool:
    return tree['window'] is not None

def get_windows(tree) -> List[Window]:
    if is_window(tree):
        return [Window(tree)]

def get_current_workspace_name() -> str:
    for ws in i3.get_workspaces():
        if ws['focused']:
            return ws['name']

def get_current_workspace_tree():
    workspace_name = get_current_workspace_name()

    has_name = lambda t: t['name'] == workspace_name
    return i3.filter(i3.get_tree(), has_name)[0]
    
def size(tree) -> int:
    if tree['window']:
        return 1
    else:
        return sum(map(size, tree['nodes']))

def along_top(tree) -> List[Window]:
    if is_window(tree):
        return [Window(tree)]
    elif tree['layout'] == "splitv":
        return along_top(tree['nodes'][0])
    else:
        windows = []
        for node in tree['nodes']:
            windows += along_top(node)
        return windows

def along_bottom(tree) -> List[Window]:
    print("TREE: " + str(tree['name']))
    print("IS WINDOW: " + str(is_window(tree)))
    print("NODES: " + str(len(tree['nodes'])))
    if is_window(tree):
        return [Window(tree)]
    elif tree['layout'] == "splitv":
        return along_bottom(tree['nodes'][-1]).reverse()
    else:
        windows = []
        for node in tree['nodes']:
            windows += along_bottom(node)
        return windows.reverse()

def along_left(tree) -> List[Window]:
    if not tree['nodes']:
        return get_windows(tree)
    if tree['layout'] == "splith":
        return list(along_left(tree['nodes'][0])).reverse()
    else:
        windows = []
        for node in tree['nodes']:
            windows += along_left(node)
        return windows.reverse()

def along_right(tree) -> List[Window]:
    if not tree['nodes']:
        return get_windows(tree)
    if tree['layout'] == "splith":
        return along_right(tree['nodes'][-1])
    else:
        windows = []
        for node in tree['nodes']:
            windows += along_right(node)
        return windows

#print(along_top(get_current_workspace_tree()))
print(along_bottom(get_current_workspace_tree()))
#print(along_right(get_current_workspace_tree()))
#print(along_left(get_current_workspace_tree()))
