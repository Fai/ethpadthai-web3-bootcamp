class Document():
    def __init__(self, key, value):
        self.key = key
        self.value = value

class Collection():
    def __init__(self) -> None:
        self.documents = []

    def add_document(self, document):
        self.documents.append(document)
    
    def delete_document(self, key):
        for i in range(len(self.documents)):
            if self.documents[i].key == key:
                self.documents.pop(i)
                break
    
    def get_document(self, key):
        for i in range(len(self.documents)):
            if self.documents[i].key == key:
                return self.documents[i]
        return None
    
    def update_document(self, key, value):
        for i in range(len(self.documents)):
            if self.documents[i].key == key:
                self.documents[i].value = value
                break

    def compare_document(self, key, value):
        for i in range(len(self.documents)):
            if self.documents[i].key == key:
                return self.documents[i].value == value
        return False