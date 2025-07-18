package com.tugra.handler;

import com.tugra.exception.BaseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.net.InetAddress;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(value = BaseException.class)
    public ResponseEntity<ApiError> GlobalExceptionHandler(BaseException exception , WebRequest request) {
        return ResponseEntity.badRequest().body(createdApiError(exception.getMessage() , request));
    }

    public String getHostName() {

        try {
            InetAddress inetAddress = InetAddress.getLocalHost();
            return inetAddress.getHostName();
        }catch (java.lang.Exception exception){
            exception.printStackTrace();
        }
        return null;
    }


    public <T> ApiError<T> createdApiError(T message , WebRequest request) {
        ApiError<T> apiError = new ApiError<>();
        apiError.setStatus(HttpStatus.BAD_REQUEST.value());

        Exception<T> exception = new Exception<>();
        exception.setPath(request.getDescription(false));
        exception.setHostName(getHostName());
        exception.setMessage(message);

        apiError.setException(exception);
        return apiError;
    }

}
