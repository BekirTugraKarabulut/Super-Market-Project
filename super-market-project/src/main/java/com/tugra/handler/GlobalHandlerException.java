package com.tugra.handler;

import com.tugra.exception.BaseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.net.InetAddress;

@ControllerAdvice
public class GlobalHandlerException {

    @ExceptionHandler(value = BaseException.class)
    public ResponseEntity<ApiError> GlobalHandlerException(BaseException baseException , WebRequest request) {

        return ResponseEntity.badRequest().body(createdApiError(baseException.getMessage() , request));
    }

    public <T> ApiError<T> createdApiError(T message , WebRequest request){

        ApiError<T> apiError = new ApiError<>();
        apiError.setStatus(HttpStatus.BAD_REQUEST.value());

        Exception<T> exception = new Exception<>();
        exception.setHostName(getHostName());
        exception.setPath(request.getDescription(false));
        exception.setMessage(message);

        apiError.setException(exception);
        return apiError;
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

}
