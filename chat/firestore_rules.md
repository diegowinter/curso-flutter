# Regras para o Firebase Cloud Firestore

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
  	match /users/{uid} {
      allow write: if request.auth != null && request.auth.uid == uid;
	}
    
  	match /users/{uid} {
      allow read: if request.auth != null;
	}
    
    match /chat/{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```