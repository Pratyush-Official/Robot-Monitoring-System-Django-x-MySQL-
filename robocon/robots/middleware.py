import logging
import time

logger = logging.getLogger(__name__)

# ─── 1. REQUEST LOGGER MIDDLEWARE ────────────────────────────────────
class RequestLoggerMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        start_time = time.time()

        # Log incoming request
        logger.info(f'[REQUEST] {request.method} {request.path} '
                   f'| User: {request.user} '
                   f'| IP: {request.META.get("REMOTE_ADDR")}')

        response = self.get_response(request)

        duration = time.time() - start_time

        # Log outgoing response
        logger.info(f'[RESPONSE] {request.method} {request.path} '
                   f'| Status: {response.status_code} '
                   f'| Duration: {duration:.2f}s')

        return response


# ─── 2. SECURITY HEADERS MIDDLEWARE ──────────────────────────────────
class SecurityHeadersMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)

        # Add security headers to every response
        response['X-Content-Type-Options'] = 'nosniff'
        response['X-Frame-Options'] = 'DENY'
        response['X-XSS-Protection'] = '1; mode=block'
        response['Referrer-Policy'] = 'same-origin'

        return response


# ─── 3. ERROR HANDLING MIDDLEWARE ────────────────────────────────────
class ErrorHandlingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        return response

    def process_exception(self, request, exception):
        logger.error(f'[ERROR] {request.method} {request.path} '
                    f'| Exception: {exception} '
                    f'| User: {request.user}')
        return None