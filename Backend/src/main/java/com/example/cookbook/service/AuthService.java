package com.example.cookbook.service;

import java.util.Collection;
import java.util.concurrent.ExecutionException;

import com.example.cookbook.dto.SigninDTO;
import com.example.cookbook.dto.SignupDTO;
import com.example.cookbook.dto.UserDTO;
import com.example.cookbook.interfaces.ServiceInterface;
import com.example.cookbook.repository.UsersRepository;
import com.google.firebase.auth.ActionCodeSettings;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.auth.ActionCodeSettings.Builder;
import com.google.firebase.auth.UserRecord.CreateRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService implements ServiceInterface<SignupDTO> {

    @Autowired
    private UsersRepository usersRepository;

    private FirebaseAuth auth;

    public UserDTO signup(SignupDTO signupDTO) throws InterruptedException, ExecutionException, FirebaseAuthException {

        this.auth = FirebaseAuth.getInstance();

        // Creates the user in Firebase authentication service.
        CreateRequest request = new CreateRequest()
            .setEmail(signupDTO.getEmail())
            .setEmailVerified(false)
            .setPassword(signupDTO.getPassword())
            .setPhoneNumber("+543416620882")
            .setDisplayName(signupDTO.getName().toString())
            .setPhotoUrl("https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png")
            .setDisabled(false);
        UserRecord userRecord = this.auth.createUser(request);


        UserDTO userDTO = new UserDTO(signupDTO.getEmail(), signupDTO.getName(), "", userRecord.getPhotoUrl(),
                userRecord.getUid(), signupDTO.getRole());

        // Creates the user in Firestore database
        UserDTO createdUserDTO = usersRepository.create(userDTO);
        return createdUserDTO;
    }

    public String signin(SigninDTO signinDTO) throws InterruptedException, ExecutionException, FirebaseAuthException {

        this.auth = FirebaseAuth.getInstance();

        ActionCodeSettings settings = ActionCodeSettings.builder().setAndroidPackageName("com.example.Cookbook.dev").build();
        String result = this.auth.generateSignInWithEmailLink(signinDTO.getEmail(), settings);
        
        return result;
    }

    @Override
    public void create(SignupDTO product) {

    }

    @Override
    public void update(String uid, SignupDTO product) {

    }

    @Override
    public void delete(String uid) {

    }

    @Override
    public SignupDTO get(String uid) {
        return null;
    }

    @Override
    public Collection<SignupDTO> getAll() {
        return null;
    }
}